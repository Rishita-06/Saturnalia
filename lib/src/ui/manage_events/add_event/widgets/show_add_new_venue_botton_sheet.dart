// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:Saturnalia/src/models/location_data.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

showAddNewvenueBottomSheet(BuildContext context) {
  return showSaturnaliaBottomSheet(
      context: context, builder: (context) => _AddVenueBottomSheet());
}

class _AddVenueBottomSheet extends ConsumerStatefulWidget {
  const _AddVenueBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AddVenueBottomSheetState();
}

class __AddVenueBottomSheetState extends ConsumerState<_AddVenueBottomSheet> {
  GeoPoint? geoPoint;
  String name = '';
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final res = await showSimplePickerLocation(
                        context: context,
                        initPosition:
                            GeoPoint(latitude: 30.353539, longitude: 76.368524),
                        zoomOption: const ZoomOption(
                          initZoom: 16,
                          minZoomLevel: 16,
                          maxZoomLevel: 18,
                        ),
                        isDismissible: true,
                      );
                      if (res == null) {
                        showErrorMessage(context, 'Location not picked!');
                      } else {
                        setState(() {
                          geoPoint = res;
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: secondaryColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Pick Location',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (geoPoint != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Picked Location',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Latitude : ',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                geoPoint!.latitude.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.51),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Longitude : ',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                geoPoint!.longitude.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.51),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Venue Name(in short)',
                style: GoogleFonts.rocknRollOne(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                maxLength: 20,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: const Color(0xff181818),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: secondaryColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1.5,
                    ),
                  ),
                  hintText: 'Tan,Main Audi, etc...',
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 13,
                    color: primaryColor.withOpacity(0.5),
                  ),
                ),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onTap: () async {
                  if (!isProcessing) {
                    setState(() {
                      isProcessing = true;
                    });
                    final res = await _addLocation(geoPoint, ref);
                    if (res != '') {
                      showErrorMessage(context, res);
                      setState(() {
                        isProcessing = false;
                      });
                    } else {
                      showSuccessMessage(context, 'Venue Added');
                      context.maybePop();
                    }
                  }
                },
                text: 'Add Venue',
                isProcessing: isProcessing,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _addLocation(GeoPoint? geoPoint, WidgetRef ref) async {
    if (geoPoint == null) {
      return 'Please pick location first';
    }
    if (name.trim().isEmpty) {
      return 'please enter venue name';
    }
    final id = prettyTimeStamp12(DateTime.now());

    try {
      await ref
          .read(firebaseFirestoreProvider)
          .collection('locations')
          .doc(id.toString())
          .set({
        'geoPoints': LocationData(
          id: id,
          longitude: geoPoint.longitude,
          latitude: geoPoint.latitude,
          venue: name.trim(),
        ).toJson(),
      });

      return '';
    } catch (e) {
      return e.toString();
    }
  }
}
