import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as geo;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../logic/services/firebase_firestore.dart';
import '../../models/event_details.dart';

part 'events_map_model.freezed.dart';

final eventMapPageProvider =
    StateNotifierProvider.autoDispose<EventPageModel, EventPageState>(
  (ref) => EventPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class EventPageModel extends StateNotifier<EventPageState> {
  final FirebaseFirestore firebaseFirestore;
  EventPageModel({required this.firebaseFirestore})
      : super(const EventPageState());
  setGeoPoint(geo.GeoPoint? geoPoint) {
    state = state.copyWith(
      geoPoint: geoPoint,
    );
  }

  init(List<EventDetails> eventList) {
    state = state.copyWith(
      eventList: eventList,
    );
  }
}

@freezed
class EventPageState with _$EventPageState {
  const factory EventPageState({
    @Default(0) int userBalance,
    @Default(null) geo.GeoPoint? geoPoint,
    @Default(null) List<EventDetails>? eventList,
  }) = _EventPageState;
}
