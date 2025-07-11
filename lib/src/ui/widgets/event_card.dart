import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../constants/colors.dart';

class EventCard extends ConsumerStatefulWidget {
  final EventDetails data;
  final bool isVisible;
  const EventCard({
    super.key,
    required this.data,
    required this.isVisible,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  @override
  Widget build(BuildContext context) {
    const double width = 190;
    const double height = 200;
    return !widget.isVisible
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                context.navigateTo(EventRoute(data: widget.data));
              },
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: scaffoldColor,
                  ),
                  color: secondaryContainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.data.details.imageUrl == null ||
                                widget.data.details.imageUrl == ''
                            ? "https://firebasestorage.googleapis.com/v0/b/sat-app-b9f71.appspot.com/o/events%2FRectangle%2012.png?alt=media&token=6947e9cd-0367-404f-8252-cbe9c9200ae9"
                            : widget.data.details.imageUrl!,
                        fit: BoxFit.cover,
                        height: 115,
                        // color: Colors.black.withOpacity(0.4),
                        // colorBlendMode: BlendMode.darken,
                        width: width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.data.details.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white.withOpacity(0.6),
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.data.details.venue,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffC8C8C8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              prettyTimeStamp2(widget.data.details.eventDate)
                                  .toString()
                                  .replaceFirst(' ', '\n'),
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
