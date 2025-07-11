import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../../logic/repositories/events_repository/events_respository.dart';
import '../../../utils/time_utils.dart';

class InformalEventsSection extends ConsumerStatefulWidget {
  const InformalEventsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InformalEventsSectionState();
}

class _InformalEventsSectionState extends ConsumerState<InformalEventsSection> {
  @override
  Widget build(BuildContext context) {
    final eventList = ref
        .watch(eventsPageProvider.select(
          (_) => _.allPublicEvents,
        ))
        ?.where((element) => element.isInformal)
        .toList();

    return (eventList != null && eventList.isNotEmpty)
        ? Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Informal Events'.toUpperCase(),
                      style: GoogleFonts.rocknRollOne(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 85,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: eventList.length,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                          onTap: () {
                            context
                                .navigateTo(EventRoute(data: eventList[index]));
                          },
                          child: _informalEventCard(data: eventList[index]))),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}

class _informalEventCard extends ConsumerStatefulWidget {
  final EventDetails data;
  const _informalEventCard({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __informalEventCardState();
}

class __informalEventCardState extends ConsumerState<_informalEventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 190,
        decoration: BoxDecoration(
          color: secondaryContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.data.details.imageUrl == null ||
                        widget.data.details.imageUrl == ''
                    ? "https://firebasestorage.googleapis.com/v0/b/sat-app-b9f71.appspot.com/o/events%2FRectangle%2012.png?alt=media&token=6947e9cd-0367-404f-8252-cbe9c9200ae9"
                    : widget.data.details.imageUrl!,
                fit: BoxFit.cover,
                height: 90,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
                width: 190,
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: SizedBox(
                height: 90,
                width: 190,
                child: Text(
                  widget.data.details.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
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
                    ),
                    Expanded(
                      child: Text(
                        prettyTimeStamp2(widget.data.details.eventDate)
                            .toString(),
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
            ),
          ],
        ));
  }
}
