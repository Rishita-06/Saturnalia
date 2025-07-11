import 'dart:io';

import 'package:Saturnalia/src/models/price_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Saturnalia/src/logic/services/firebase_storage_service.dart';
import 'package:Saturnalia/src/models/dynamic_form_data.dart';
import 'package:Saturnalia/src/models/form_data.dart';
import 'package:uuid/uuid.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../logic/services/firebase_firestore.dart';
import '../../../models/event_data.dart';
import '../../../models/event_details.dart';
import '../../../utils/network_utils.dart';

part 'add_event_model.freezed.dart';

final addEventModelProvider =
    StateNotifierProvider.autoDispose<AddEventPageModel, AddEventPageState>(
  (ref) => AddEventPageModel(
    firebaseStorageService: ref.read(firebaseStorageServiceProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class AddEventPageModel extends StateNotifier<AddEventPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  final FirebaseStorageService firebaseStorageService;
  AddEventPageModel({
    required this.firebaseFirestore,
    required this.firebaseStorageService,
    required this.ref,
  }) : super(const AddEventPageState());

  init(EventDetails eventDetails) {
    final details = eventDetails.details;
    final formData = eventDetails.formData;
    state = state.copyWith(
      isPublic: eventDetails.isPublic,
      eventTitle: details.title,
      eventDate: details.eventDate,
      tags: details.tag,
      description: details.description,
      bannerImageUrl: details.imageUrl!,
      registrationType: details.hasFormData,
      fieldList: formData?.data ?? [],
      location: details.location,
      isFeatured: eventDetails.isFeatured,
      editors: eventDetails.editors ?? [],
      // userName: eventDetails.userName,
      eventImages: eventDetails.images,
      startDate: formData?.startDate,
      endDate: formData?.endDate,
      pointOfContact: details.pointOfContact,
      isEditing: true,
      priceData: eventDetails.priceData ?? [],
      isInformal: eventDetails.isInformal,
      rulesAndRegulation: details.rulesAndRegulation,
      registrationProcess: details.registrationProcess,
      termsAndCondition: details.termsAndCondition,
      eventEndDate: details.eventEndDate,
      venueName: details.venue,
      eventId: details.eventId,
      eventType: eventDetails.registrationType,
      eventVisibility: eventDetails.eventVisibility,
      teamMinSize: formData?.teamMinSize ?? 1,
      teamMaxSize: formData?.teamMaxSize ?? 1,
      link: details.link ?? [],
    );
  }

  setEventName(String name) {
    state = state.copyWith(eventTitle: name);
  }

  setTags(String tag) {
    state = state.copyWith(tags: "${state.tags}-$tag");
  }

  removeTags(String tag) {
    state = state.copyWith(tags: state.tags.toString().replaceAll(tag, ''));
  }

  setEventDate(DateTime? dateTime) {
    state = state.copyWith(eventDate: dateTime);
  }

  setEventEndDate(DateTime? dateTime) {
    state = state.copyWith(eventEndDate: dateTime);
  }

  setStartDate(DateTime? dateTime) {
    state = state.copyWith(startDate: dateTime);
  }

  addLink() {
    state = state.copyWith(link: state.link.toList()..add(''));
  }

  setLink(int index, String link) {
    List<String> links = state.link.toList();
    links[index] = link;
    state = state.copyWith(link: links);
  }

  removeLink(int index) {
    state = state.copyWith(link: state.link.toList()..removeAt(index));
  }

  setEndDate(DateTime? dateTime) {
    state = state.copyWith(endDate: dateTime);
  }

  setLocation(int id) {
    state = state.copyWith(location: id);
  }

  setDescription(String name) {
    state = state.copyWith(description: name);
  }

  setRules(String name) {
    state = state.copyWith(rulesAndRegulation: name);
  }

  setTerms(String name) {
    state = state.copyWith(termsAndCondition: name);
  }

  setRegistration(String name) {
    state = state.copyWith(registrationProcess: name);
  }

  setPointOfContact(String name) {
    state = state.copyWith(pointOfContact: name);
  }

  setFormData(List<DyamicFormData> data) {
    state = state.copyWith(
      fieldList: data,
    );
  }

  setVenueName(String name) => state = state.copyWith(venueName: name);

  setRegistrationType(int? registrationType) => state = state.copyWith(
        registrationType: registrationType ?? 3,
      );

  Future<String> pickFile(String type) async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      File file = File(result.path);
      // debugPrint('file found : ${file.path.toString()}');
      final res = await uploadFile(file, type);
      return res;
    } else {
      // debugPrint('file not picked');
      return 'File Not Picked';
    }
  }

  Future<String> uploadFile(File file, String type) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection';
    }
    state = state.copyWith(uploadStatus: UploadStatus.uploading);

    firebaseStorageService.uploadFile(
      filename: DateTime.now().microsecondsSinceEpoch.toString(),
      file: file,
      onComplete: (storageReference) async {
        try {
          final mediaUrl = await storageReference.getDownloadURL();
          await setBannerUrl(mediaUrl, type);
          return '';
        } catch (e) {
          return e.toString();
        }
      },
    );
    return '';
  }

  setBannerUrl(String url, String type) async {
    if (!state.isEditing) {
      if (state.bannerImageUrl.trim().isNotEmpty && type == 'banner') {
        await firebaseStorageService.deleteFile(state.bannerImageUrl);
      }
    }
    state = state.copyWith(
      bannerImageUrl: type == 'banner' ? url : state.bannerImageUrl,
      eventImages: type == 'display'
          ? (state.eventImages.toList()..add(url))
          : state.eventImages,
    );
  }

  removeImage(String url) async {
    state = state.copyWith(
      eventImages: state.eventImages.toList()..remove(url),
    );
    if (!state.isEditing) {
      if (url.trim().isNotEmpty) {
        await firebaseStorageService.deleteFile(url);
      }
    }
  }

  setEventType(int id) {
    state = state.copyWith(
      eventType: id,
    );
  }

  setTeamMaxSize(int id) {
    state = state.copyWith(
      teamMaxSize: id,
    );
  }

  setTeamMinSize(int id) {
    state = state.copyWith(
      teamMinSize: id,
    );
  }

  setEventVisibility(int id) {
    state = state.copyWith(
      eventVisibility: id,
    );
  }

  bool checkLink(String text) {
    // Regular expression to match common URL patterns
    final RegExp linkRegExp = RegExp(
        r'^(http|https|ftp):\/\/[A-Za-z0-9\.-]{3,}\.[A-Za-z]{2,}(\S*|\/|\/\S+)?$');

    return linkRegExp.hasMatch(text);
  }

  Future<String> addEvent() async {
    if (state.eventTitle.trim().isEmpty) {
      return 'Enter event name';
    }
    if (state.tags.replaceAll('-', '').trim().isEmpty) {
      return 'Please choose atleast one tag';
    }
    if (state.eventDate == null) {
      return 'Please enter event date';
    }

    if (state.location == null) {
      return 'Please choose venue';
    }
    if (state.description.trim().isEmpty) {
      return 'Please enter description';
    }
    if (state.bannerImageUrl.trim().isEmpty) {
      return 'Please add banner';
    }
    if (state.eventImages.isEmpty) {
      return 'Please add atleast one display image';
    }
    if (state.link.isNotEmpty) {
      final link = state.link;
      for (int i = 0; i < link.length; i++) {
        if (link[i].trim().isEmpty) {
          return 'Please enter ${i + 1} link';
        } else if (Uri.tryParse(link[i]) == null) {
          return 'Please enter correct link';
        } else if (!checkLink(link[i])) {
          return 'Invalid link ${i + 1}';
        }
      }
    }
    if (state.registrationType != 3) {
      if (state.startDate == null) {
        return 'Please enter registration start date';
      }
      if (state.endDate == null) {
        return 'Please enter registration end date';
      }
      if (state.endDate!.compareTo(state.startDate!) < 0) {
        return 'End date should be greater than start date';
      }
      if (state.registrationType == 2) {
        if (state.fieldList.isEmpty) {
          return 'please create form';
        }
      }
    }
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }

    final userId = ref.watch(
      appRepositoryProvider.select((_) => _.userData!.userId),
    );
    List<String> editor = state.editors.toList();
    editor.contains(userId) ? null : editor.add(userId);
    const uuid = Uuid();
    final v1 = uuid.v1();
    state = state.copyWith(
      eventData: EventDetails(
        isPublic: state.isPublic,
        details: EventData(
          eventId: state.isEditing ? state.eventId : 'event-$v1',
          description: state.description,
          tag: state.tags,
          imageUrl: state.bannerImageUrl,
          eventDate: state.eventDate!,
          location: state.location!,
          hasFormData: state.registrationType,
          venue: state.venueName,
          title: state.eventTitle,
          rulesAndRegulation: state.rulesAndRegulation,
          registrationProcess: state.registrationProcess,
          termsAndCondition: state.termsAndCondition,
          pointOfContact: state.pointOfContact,
          eventEndDate: state.eventEndDate,
          link: state.link,
          scanningStarted: false,
        ),
        editors: editor,
        priceData: state.priceData,
        isInformal: state.isInformal,
        images: state.eventImages,
        isFeatured: state.isFeatured,
        eventVisibility: state.eventVisibility,
        registrationType: state.eventType,
        formData: state.registrationType == 3
            ? null
            : FormData(
                endDate: state.endDate!,
                data: state.fieldList,
                teamMinSize: state.teamMinSize,
                teamMaxSize: state.teamMaxSize,
                startDate: state.startDate!,
              ),
      ),
    );

    return '';
  }
}

@freezed
class AddEventPageState with _$AddEventPageState {
  const factory AddEventPageState({
    @Default('') String eventTitle,
    @Default('') String description,
    @Default('') String tags,
    @Default(null) DateTime? eventEndDate,
    @Default('') String rulesAndRegulation,
    @Default('') String termsAndCondition,
    @Default('') String registrationProcess,
    @Default('') String pointOfContact,
    @Default('') String venueName,
    @Default([]) List<String> editors,
    @Default(null) int? location,
    @Default(null) DateTime? eventDate,
    @Default(null) DateTime? startDate,
    @Default(null) DateTime? endDate,
    @Default([]) List<DyamicFormData> fieldList,
    @Default(null) bool? isPublic,
    @Default(1) int eventType,
    @Default(1) int eventVisibility,
    @Default(1) int teamMinSize,
    @Default(1) int teamMaxSize,
    @Default(3) int registrationType,
    @Default([]) List<String> eventImages,
    @Default([]) List<String> link,
    @Default(false) bool isInformal,
    @Default([]) List<PriceData> priceData,
    @Default('') String bannerImageUrl,
    @Default(null) EventDetails? eventData,
    @Default(false) bool isEditing,
    @Default(false) bool isFeatured,
    @Default('') String eventId,
    @Default(UploadStatus.initial) UploadStatus uploadStatus,
  }) = _AddEventPageState;
}

enum UploadStatus {
  initial,
  uploading,
  uploaded,
  error,
}
