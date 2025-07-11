import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/location_data.dart';
import '../../services/firebase_firestore.dart';

import '../../../models/event_details.dart';
import '../app_repository/app_repository.dart';

part 'events_respository.freezed.dart';

final eventsPageProvider =
    StateNotifierProvider<EventsPageModel, EventsPageState>(
  (ref) => EventsPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class EventsPageModel extends StateNotifier<EventsPageState> {
  final FirebaseFirestore firebaseFirestore;
  final StateNotifierProviderRef ref;
  late final StreamSubscription _subscription;
  late final StreamSubscription _subscription2;
  EventsPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const EventsPageState()) {
    getEvents();
    getCoordinates();
  }

  getEvents() async {
    try {
      state = state.copyWith(
        status: EventStatus.loading,
      );
      final thapar = ref.watch(
        appRepositoryProvider.select((_) => _.thaparId),
      );
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";

      _subscription = firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .orderBy('details.eventDate', descending: false)
          .snapshots()
          .listen((documents) async {
        if (documents.docs.isNotEmpty) {
          List<EventDetails> data = [];
          data = documents.docs
              .map((e) => EventDetails.fromJson(e.data()))
              .toList();
          state = state.copyWith(
              eventList: data,
              allPublicEvents: data
                  .where((e) =>
                      e.isPublic == true &&
                      (e.eventVisibility == 3 ||
                          (e.eventVisibility == 2 && !thapar) ||
                          (e.eventVisibility == 1 && thapar)))
                  .toList());
          if (mounted) {
            await getCoordinates();
            await getUserEvents();
          }
        } else {
          state = state.copyWith(
            status: EventStatus.loaded,
            eventList: [],
            allPublicEvents: [],
          );
        }
      });
    } catch (e) {
      state = state.copyWith(status: EventStatus.error);
    }
  }

  Future<void> getUserEvents() async {
    final eventsList = ref.watch(
          appRepositoryProvider.select((_) => _.userData!.events),
        ) ??
        [];
    List<EventDetails> userEvents = [];
    if (eventsList.isEmpty) {
      return;
    }
    for (var event in eventsList) {
      final data = state.allPublicEvents
          ?.indexWhere((element) => element.details.eventId == event);

      if (data != -1) {
        userEvents.add(state.allPublicEvents![data!]);
      }
    }
    state = state.copyWith(
        userEvents: userEvents
          ..sort((a, b) => a.details.eventDate.compareTo(b.details.eventDate)));
  }

  Future<void> getCoordinates() async {
    try {
      _subscription2 = firebaseFirestore
          .collection('locations')
          .snapshots()
          .listen((documents) {
        if (documents.docs.isNotEmpty) {
          if (mounted) {
            state = state.copyWith(
              locationData: documents.docs
                  .map((e) => LocationData.fromJson(e.data()['geoPoints']))
                  .toList(),
            );
          }

          state = state.copyWith(status: EventStatus.loaded);
        } else {
          state = state.copyWith(
            status: EventStatus.loaded,
            locationData: [],
          );
        }
      });
    } catch (e) {
      state = state.copyWith(status: EventStatus.error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _subscription2.cancel();
  }
}

@freezed
class EventsPageState with _$EventsPageState {
  const factory EventsPageState({
    @Default(0) int userBalance,
    @Default(null) List<LocationData>? locationData,
    @Default(null) List<EventDetails>? allPublicEvents,
    @Default(null) List<EventDetails>? eventList,
    @Default([]) List<EventDetails> userEvents,
    @Default(false) bool refresh,
    @Default(EventStatus.initial) EventStatus status,
  }) = _EventsPageState;
}

enum EventStatus {
  initial,
  loading,
  loaded,
  error,
}
