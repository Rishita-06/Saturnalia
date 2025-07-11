import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';

import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../../constants/colors.dart';
import '../../../logic/repositories/events_repository/events_respository.dart';
import '../../../models/event_details.dart';
import '../../../routing/router.dart';
import '../../../utils/dialog_utils.dart';

import '../events_map_model.dart';
import 'event_info_map_card.dart';

class EventMapBottomSheet extends ConsumerWidget {
  final MapController controller;
  final Function() onChanged;
  const EventMapBottomSheet({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geoPoint = ref.watch(
      eventMapPageProvider.select(
        (_) => _.geoPoint,
      ),
    );

    return (geoPoint == null)
        ? const SizedBox()
        : Container(
            height: 40,
            width: 60,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () async {
                showEventListBottomSheet(context, controller, ref, onChanged);
              },
              icon: const Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          );
  }
}

showEventListBottomSheet(
  BuildContext context,
  MapController controller,
  WidgetRef ref,
  Function() onChanged,
) {
  final eventData = ref.watch(
    eventMapPageProvider.select(
      (_) => _.eventList,
    ),
  );
  final geoPoint = ref.watch(
    eventMapPageProvider.select(
      (_) => _.geoPoint,
    ),
  );
  final locationData = ref.watch(
    eventsPageProvider.select(
      (_) => _.locationData,
    ),
  );

  return showSaturnaliaBottomSheet(
    context: context,
    builder: (context) => EventInfoSheet(
      controller: controller,
      geoPoint: geoPoint!,
      data: eventData
          ?.where((element) =>
              locationData
                  ?.firstWhere((e) => element.details.location == e.id)
                  .latitude ==
              geoPoint.latitude)
          .toList(),
      onChanged: onChanged,
    ),
  );
}

class EventInfoSheet extends ConsumerWidget {
  final MapController controller;
  final GeoPoint geoPoint;
  final Function() onChanged;
  final List<EventDetails>? data;
  const EventInfoSheet({
    super.key,
    required this.controller,
    required this.geoPoint,
    required this.onChanged,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          color: secondaryContainerColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          if (data != null)
            if (data!.length != 1) ...[
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (contex, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: EventInfoMapCard(
                      onTap: () {
                        context.navigateTo(
                          EventRoute(data: data![index]),
                        );
                      },
                      data: data![index],
                      isVisible: true,
                    ),
                  ),
                  itemCount: data?.length,
                ),
              ),
            ] else if (data!.length == 1) ...[
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    data!.first.details.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rocknRollOne(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data!.first.details.venue,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      prettyTimeStamp9(data!.first.details.eventDate),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          if (Platform.isAndroid)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    onTap: () async {
                      Navigator.pop(context);
                      await controller.clearAllRoads();
                      final geoPoints = await controller.myLocation();

                      await controller.drawRoad(
                        geoPoints,
                        geoPoint,
                        roadType: RoadType.car,
                        roadOption: const RoadOption(
                          roadColor: primaryColor,
                          roadWidth: 15,
                          zoomInto: true,
                        ),
                      );
                      await controller.enableTracking(
                        enableStopFollow: true,
                        disableUserMarkerRotation: true,
                      );
                      controller.rotateMapCamera(98);
                      await onChanged();
                    },
                    text: 'Start Navigation',
                    isProcessing: false),
              ],
            ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
