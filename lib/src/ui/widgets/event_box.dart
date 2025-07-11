import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import '../../models/event_details.dart';

import '../../utils/time_utils.dart';

class AllEventBox extends ConsumerWidget {
  final EventDetails eventData;
  final VoidCallback onTap;
  final bool isEditing;
  const AllEventBox({
    super.key,
    required this.eventData,
    this.isEditing = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width - 41;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width,
            height: 199,
            decoration: BoxDecoration(
              color: secondaryContainerColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: eventData.details.imageUrl == null ||
                            eventData.details.imageUrl == ''
                        ? "https://firebasestorage.googleapis.com/v0/b/sat-app-b9f71.appspot.com/o/events%2FRectangle%2012.png?alt=media&token=6947e9cd-0367-404f-8252-cbe9c9200ae9"
                        : eventData.details.imageUrl!,
                    fit: BoxFit.cover,
                    height: 112,
                    width: width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        eventData.details.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.3),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            eventData.details.venue,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffC8C8C8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_sharp,
                            color: Colors.white.withOpacity(0.3),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            prettyTimeStamp10(eventData.details.eventDate),
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffC8C8C8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/ic_forward.png',
                height: 44,
                width: 44,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
