import 'dart:io';

import 'package:Saturnalia/src/logic/services/firebase_storage_service.dart';
import 'package:Saturnalia/src/models/responses/team_details.dart';
import 'package:Saturnalia/src/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../models/dynamic_form_data.dart';
import '../../models/responses/form_response_data.dart';
import '../../models/reward_points_data.dart';

import '../../utils/network_utils.dart';
import '../../utils/project_utils.dart';

part 'form_page_model.freezed.dart';

final formPageProvider =
    StateNotifierProvider.autoDispose<FormPageModel, FormPageState>(
  (ref) => FormPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    firebaseStorageService: ref.read(firebaseStorageServiceProvider),
    ref: ref,
  ),
);

class FormPageModel extends StateNotifier<FormPageState> {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorageService firebaseStorageService;
  final AutoDisposeStateNotifierProviderRef ref;

  FormPageModel({
    required this.firebaseFirestore,
    required this.ref,
    required this.firebaseStorageService,
  }) : super(const FormPageState());
  init(List<DyamicFormData> data, String eventId, String eventName,
      int maxTeamSize) {
    try {
      state = state.copyWith(status: FormPageStatus.loading);
      state = state.copyWith(
        responses: data
            .map((e) => FormResponseData(
                type: e.type, id: e.id, title: e.data.title, value: ''))
            .toList(),
        eventId: eventId,
        maxTeamSize: maxTeamSize,
        eventName: eventName,
      );

      state = state.copyWith(status: FormPageStatus.loaded);
    } catch (e) {
      state = state.copyWith(status: FormPageStatus.error);
    }
  }

  Future<String> setParticipant(int id) async {
    if (id == 1) {
      if (!await hasInternetAccess()) {
        return 'No Internet Connection!';
      }
      final userData = ref.read(
        appRepositoryProvider.select((_) => _.userData),
      );
      if (userData == null) {
        return 'Something Went Wrong';
      }
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('room')
          .doc(userData.userId)
          .set({
        'roomType': 0,
        'teamId': '',
        'teamName': '',
        'teamSize': 0,
        'teamStatus': false,
        'userId': userData.userId,
        'memberId': generateReferralCode(
            state.eventId.substring(0, 10) + userData.userId.substring(0, 15),
            false)
      });
    }

    state = state.copyWith(participant: id);
    return '';
  }

  Future<String> pickFile(int id) async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      File file = File(result.path);
      // debugPrint('file found : ${file.path.toString()}');
      final res = await uploadFile(file, id);
      return res;
    } else {
      // debugPrint('file not picked');
      return 'File Not Picked';
    }
  }

  Future<String> uploadFile(File file, int id) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection';
    }
    state = state.copyWith(uploadStatus: ImageUploadStatus.loading);

    firebaseStorageService.uploadFile(
      storageName: 'payments',
      filename: DateTime.now().microsecondsSinceEpoch.toString(),
      file: file,
      onComplete: (storageReference) async {
        try {
          final mediaUrl = await storageReference.getDownloadURL();

          await updateValue(id, mediaUrl);

          return '';
        } catch (e) {
          state = state.copyWith(uploadStatus: ImageUploadStatus.error);

          return e.toString();
        }
      },
    );
    return '';
  }

  setTeamSize(int size) {
    state = state.copyWith(
      teamSize: size,
      teamDetails: state.teamDetails.isEmpty
          ? List<TeamDetails>.generate(
              ((state.maxTeamSize ?? 1) - 1),
              (i) => TeamDetails(
                  userId: '',
                  id: i,
                  collegeAddress: '',
                  email: '',
                  year: '',
                  name: '',
                  title: ''))
          : state.teamDetails,
    );
  }

  Future<Map<UserData?, String>> searchMember(String uniqueId) async {
    if (uniqueId.trim().isEmpty) {
      return {null: 'Please enter uinque id'};
    }
    final isThaparId = ref.watch(
      appRepositoryProvider.select((_) => _.thaparId),
    );

    if (!await hasInternetAccess()) {
      return {null: 'No Internet Connection!'};
    }
    final data = await firebaseFirestore
        .collection('users')
        .where('eventUniqueIds',
            arrayContains: '${state.eventId}-${uniqueId.toLowerCase()}')
        .get();

    if (data.docs.isNotEmpty) {
      if (isThaparId &&
          !(data.docs.first['email'].toString().split('@')[1] ==
              'thapar.edu')) {
        return {null: 'User entered is not a thapar student!'};
      } else if (!isThaparId &&
          (data.docs.first['email'].toString().split('@')[1] == 'thapar.edu')) {
        return {
          null: 'User entered is a thapar student\ncross college not allowed'
        };
      }
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      final resp = await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .where('userId', isEqualTo: data.docs.first['userId'])
          .get();
      if (resp.docs.isNotEmpty) {
        return {null: 'User already registered'};
      }
      return {UserData.fromJson(data.docs.first.data()): ''};
    } else {
      return {null: 'User not found'};
    }
    // return {null: 'Something Went Wrong'};
  }

  String setTeamMember(int id, UserData details) {
    List<TeamDetails> responses = state.teamDetails.toList();
    final index = responses.indexWhere((e) => e.id == id);
    if (responses
        .where((element) => element.email == details.email)
        .isNotEmpty) {
      return 'This member is already added';
    }
    final userEmail = ref.read(
            appRepositoryProvider.select((value) => value.userData?.email)) ??
        '';
    if (userEmail == details.email) {
      return 'You cannot add yourself as team member';
    }
    responses[index] = TeamDetails(
        userId: details.userId,
        id: id,
        collegeAddress:
            '${details.collegeName} ${details.collegeCity} ${details.collegeState} ${details.collegePinCode}',
        email: '${details.phoneNumber}-${details.email}',
        name: details.userName,
        year: '${details.branch}-${details.graduationYear}',
        title: 'Team Member ${id + 1} details');
    state = state.copyWith(teamDetails: responses);
    return '';
  }

  removeTeamMember(
    int id,
  ) {
    List<TeamDetails> responses = state.teamDetails.toList();
    final index = responses.indexWhere((e) => e.id == id);
    responses[index] = TeamDetails(
        userId: '',
        id: id,
        collegeAddress: '',
        email: '',
        name: '',
        title: '',
        year: '');
    state = state.copyWith(teamDetails: responses);
    return '';
  }

  updateValue(int id, String value) {
    List<FormResponseData> responses = state.responses!.toList();
    final index = responses.indexWhere((e) => e.id == id);
    responses[index] = responses[index].copyWith(value: value);
    state = state.copyWith(responses: responses);
    if (id == 5) {
      state = state.copyWith(uploadStatus: ImageUploadStatus.loaded);
    }
  }

  Future<String> registerForEvents() async {
    final userData = ref.read(
      appRepositoryProvider.select((_) => _.userData),
    );
    final userEmail = ref.read(
      appRepositoryProvider.select((_) => _.userData?.email),
    );
    final userName = ref.read(
      appRepositoryProvider.select(
        (_) => _.userData?.userName,
      ),
    );
    if (state.eventId == '') {
      return 'Something Went Wrong';
    }

    if (userData?.userId == null || userEmail == null) {
      return 'User is unauthenticated';
    }
    if (state.participant == 0) {
      final responses = state.responses!;
      for (int i = 0; i < responses.length; i++) {
        if (responses[i].value.trim().isEmpty) {
          return 'please enter ${i + 1} field value';
        }
      }
    }

    if (state.maxTeamSize != 1) {
      if (state.teamSize == null) {
        return 'please select team size';
      }
      if (state.teamSize != 1) {
        for (int i = 0; i < state.teamSize! - 1; i++) {
          if (state.teamDetails[i].email.trim().isEmpty) {
            return 'please select member ${i + 2}';
          }
        }
      }
    }
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }

    try {
      final isThaparId = ref.watch(
        appRepositoryProvider.select((_) => _.thaparId),
      );
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      const uuid = Uuid();
      final v1 = uuid.v1();
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .doc('$v1-0${userData!.userId.substring(0, 2)}')
          .set(
        {
          'userId': userData.userId,
          'isVerified': false,
          'tokenId': '$v1-0${userData.userId.substring(0, 2)}',
          'name': userName,
          'verificationTime': null,
          'userEmail': userData.email,
          'mobile': userData.phoneNumber,
          'teamDetails': state.teamDetails
              .map((e) => e.toJson())
              .toList()
              .takeWhile((value) => value['id'] < state.teamSize! - 1)
              .toList(),
          'collegeAddress':
              '${userData.collegeName} ${userData.collegeCity}, ${userData.collegeState}, ${userData.collegePinCode}',
          'isParticipant': 0,
          'paymentStatus': isThaparId,
          'formResponse': state.participant == 0
              ? state.responses!.map((e) => e.toJson()).toList()
              : null,
        },
      );
      await firebaseFirestore.collection('users').doc(userData.userId).update(
        {
          'events': (userData.events?.toList() ?? [])
            ..removeWhere((e) => e == state.eventId)
            ..add(state.eventId),
        },
      );
      await firebaseFirestore
          .collection('users')
          .doc(userData.userId)
          .collection('rewards')
          .doc('register${state.eventId}')
          .set(
            RewardPointsData(
              date: DateTime.now(),
              message: 'Pending',
              id: 'register${state.eventId}',
              coins: 40,
              isAwarded: 0,
              title: '${state.eventName}(Registration)',
            ).toJson(),
          );
      // team qr generation

      for (var team in state.teamDetails) {
        const uuid = Uuid();
        final v1 = uuid.v1();
        if (team.id < state.teamSize! - 1) {
          await firebaseFirestore
              .collection('event')
              .doc(selectedEvent)
              .collection('events')
              .doc(state.eventId)
              .collection('users')
              .doc('$v1-0${team.userId.substring(0, 2)}')
              .set(
            {
              'userId': team.userId,
              'isVerified': false,
              'tokenId': '$v1-0${team.userId.substring(0, 2)}',
              'name': team.name,
              'verificationTime': null,
              'userEmail': team.email.split('-')[1],
              'mobile': int.parse(team.email.split('-')[0].trim()),
              'teamDetails': null,
              'collegeAddress': team.collegeAddress,
              'isParticipant': 1,
              'paymentStatus': isThaparId,
              'formResponse': null,
            },
          );
          final res = await firebaseFirestore
              .collection('users')
              .doc(team.userId)
              .get();
          if (res.exists) {
            await firebaseFirestore.collection('users').doc(team.userId).update(
              {
                'events': (res.data()!['events']?.toList() ?? [])
                  ..removeWhere((e) => e == state.eventId)
                  ..add(state.eventId),
              },
            );
          }
          await firebaseFirestore
              .collection('users')
              .doc(team.userId)
              .collection('rewards')
              .doc('register${state.eventId}')
              .set(
                RewardPointsData(
                  date: DateTime.now(),
                  message: 'Pending',
                  id: 'register${state.eventId}',
                  coins: 40,
                  isAwarded: 0,
                  title: '${state.eventName}(Registration)',
                ).toJson(),
              );
        }
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }
}

@freezed
class FormPageState with _$FormPageState {
  const factory FormPageState({
    @Default(FormPageStatus.initial) FormPageStatus status,
    @Default(null) List<FormResponseData>? responses,
    @Default([]) List<TeamDetails> teamDetails,
    @Default(null) int? maxTeamSize,
    @Default(null) int? teamSize,
    @Default(ImageUploadStatus.initial) ImageUploadStatus uploadStatus,
    @Default(0) int participant,
    @Default('') String eventId,
    @Default('') String eventName,
  }) = _FormPageState;
}

enum FormPageStatus {
  initial,
  loading,
  loaded,
  error,
}

enum ImageUploadStatus {
  initial,
  loading,
  loaded,
  error,
}
