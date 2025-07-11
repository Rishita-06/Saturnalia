import 'dart:async';
import 'dart:io';

import 'package:Saturnalia/src/models/event_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../logic/services/firebase_firestore.dart';
import '../../../models/form_data.dart';
import '../../../utils/network_utils.dart';

part 'view_responses_model.freezed.dart';

final viewResponsesPageProvider = StateNotifierProvider.autoDispose<
    ViewResponsesPageModel, ViewResponsesPageState>(
  (ref) => ViewResponsesPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class ViewResponsesPageModel extends StateNotifier<ViewResponsesPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  StreamSubscription? _subscription;
  ViewResponsesPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const ViewResponsesPageState());

  init(String eventId, String eventName, bool hasForm,
      FormData? formData) async {
    state = state.copyWith(
      status: ViewResponsesPageStatus.loading,
      eventId: eventId,
      eventName: eventName,
      hasform: hasForm,
      formData: formData,
    );
    if (!await hasInternetAccess()) {
      state = state.copyWith(
        status: ViewResponsesPageStatus.noInternet,
      );
      return;
    }
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    await Future.delayed(const Duration(seconds: 1));

    _subscription = firebaseFirestore
        .collection('event')
        .doc(selectedEvent)
        .collection('events')
        .doc(eventId)
        .collection('users')
        .orderBy('name')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        try {
          state = state.copyWith(
              status: ViewResponsesPageStatus.loaded,
              data: event.docs
                  .map((e) => EventUserData.fromJson(e.data()))
                  .toList());
        } catch (e) {
          state = state.copyWith(
            status: ViewResponsesPageStatus.error,
          );
        }
      } else {
        state = state.copyWith(
          status: ViewResponsesPageStatus.loaded,
          data: [],
        );
      }
    });
  }

  Future<String> listToCsv(List<EventUserData> data) async {
    final List<List<dynamic>> csvData = [];

    // Add the header row to the CSV data
    try {
      List<String> headings = [
        "Participant",
        " Team Leader Name",
        "Email",
        "Phone Number",
        "College Addesss",
        if (state.hasform) ...state.formData!.data.map((e) => e.data.title),
        if (state.hasform && state.formData!.teamMaxSize != 1) "Team Size",
      ];
      if (state.hasform && state.formData!.teamMaxSize != 1) {
        for (var element in List<List<String>>.generate(
            state.formData!.teamMaxSize - 1,
            (i) => [
                  "Member ${i + 2} Name",
                  "Member ${i + 2} Email",
                  "Member ${i + 2} Year & Branch",
                  "Member ${i + 2} College",
                ])) {
          headings.addAll(element);
        }
      }
      csvData.add(headings);
      for (var item in data) {
        List value = [
          item.formResponse != null,
          item.name,
          item.userEmail,
          item.mobile,
          item.collegeAddress,
          if (item.formResponse != null && state.hasform)
            ...item.formResponse!.map((e) => e.value)
          else
            '',
          if (item.teamDetails != null) item.teamDetails!.length + 1 else '',
        ];
        if (item.teamDetails != null) {
          for (var teamData in item.teamDetails!) {
            value.addAll([
              teamData.name,
              teamData.email,
              teamData.year,
              teamData.collegeAddress
            ]);
          }
        }

        csvData.add(value); // Replace with your actual object properties
      }

      // Convert the CSV data to a CSV string
      String csv = const ListToCsvConverter().convert(csvData);

      return csv;
    } catch (e) {
      return '';
    }
  }

  Future<String> updatePaymentStatus(EventUserData data) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    final userId = ref.read(
      appRepositoryProvider.select((_) => _.userData!.userName),
    );
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .doc(data.tokenId)
          .update({'paymentStatus': true, 'paymentVerifiedBy': userId});
      if (data.teamDetails != null && data.teamDetails!.isNotEmpty) {
        for (var team in data.teamDetails!) {
          final tokenId = state.data
              ?.firstWhere((element) => element.userId == team.userId)
              .tokenId;
          if (tokenId != null) {
            await firebaseFirestore
                .collection('event')
                .doc(selectedEvent)
                .collection('events')
                .doc(state.eventId)
                .collection('users')
                .doc(tokenId)
                .update({'paymentStatus': true, 'paymentVerifiedBy': userId});
          }
        }
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<XFile?> saveCsvToFile({bool onlyParticipants = false}) async {
    String csv = await listToCsv(!onlyParticipants
        ? (state.data ?? [])
        : state.data
                ?.where(
                  (element) => element.formResponse != null,
                )
                .toList() ??
            []);
    if (csv.trim().isEmpty) {
      return null;
    }
    final String tempFileName =
        "${DateTime.now().millisecondsSinceEpoch}.csv"; // You can choose a different file format based on your
    final String tempFilePath =
        '${(await getTemporaryDirectory()).path}/$tempFileName';
    File file = File(tempFilePath);
    file.writeAsStringSync(csv);
    return XFile(tempFilePath);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

@freezed
class ViewResponsesPageState with _$ViewResponsesPageState {
  const factory ViewResponsesPageState({
    @Default(ViewResponsesPageStatus.initial) ViewResponsesPageStatus status,
    @Default(null) String? eventId,
    @Default(null) List<EventUserData>? data,
    @Default(null) FormData? formData,
    @Default(false) bool hasform,
    @Default('') String eventName,
  }) = _ViewResponsesPageState;
}

enum ViewResponsesPageStatus {
  initial,
  loading,
  loaded,
  error,
  noInternet,
}
