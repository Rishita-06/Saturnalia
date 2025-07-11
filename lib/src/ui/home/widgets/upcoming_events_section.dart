import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/routing/router.dart';

import 'package:Saturnalia/src/utils/time_utils.dart';

class UpComingEventsSection extends ConsumerStatefulWidget {
  const UpComingEventsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpComingEventsSectionState();
}

class _UpComingEventsSectionState extends ConsumerState<UpComingEventsSection> {
  ValueNotifier<int> myVariable = ValueNotifier<int>(0);
  Key widgetKey = UniqueKey();
  Key mainKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    List<EventDetails>? eventList = ref.watch(
      eventsPageProvider.select(
        (_) => _.allPublicEvents
            ?.where((element) =>
                element.details.eventDate.compareTo(DateTime.now()) > 0)
            .toList(),
      ),
    );
    final featuredEvent =
        eventList?.where((element) => element.isFeatured).toList() ?? [];
    ref.listen(eventsPageProvider, (prev, next) {
      if (prev?.allPublicEvents != next.allPublicEvents) {
        setState(() {
          myVariable.value++;
          widgetKey = UniqueKey();
        });
      }
    });

    return Column(
      key: mainKey,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featuredEvent.isNotEmpty
                    ? 'Featured Event'.toUpperCase()
                    : 'Upcoming Event'.toUpperCase(),
                style: GoogleFonts.rocknRollOne(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.navigateTo(const AllEventsRoute());
                  },
                  child: Text(
                    'show all',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (eventList != null) ...[
          if (eventList.isNotEmpty) ...[
            ValueListenableBuilder<int>(
              valueListenable: myVariable,
              builder: (BuildContext context, int value, Widget? child) {
                return SizedBox(
                  height: 190,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _UpcomingEventCard(
                        key: widgetKey,
                        onEnded: (value) {
                          ref.read(eventsPageProvider.notifier).getEvents();
                        },
                        data: featuredEvent.isNotEmpty
                            ? featuredEvent[0]
                            : eventList[index],
                      ),
                    ),
                    itemCount: 1,
                    shrinkWrap: true,
                  ),
                );
              },
            ),
          ] else if (eventList.isEmpty) ...[
            const _NoUpcomingEventCard(),
          ]
        ] else ...[
          const SizedBox(
            height: 190,
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}

class _UpcomingEventCard extends ConsumerStatefulWidget {
  final EventDetails data;
  final Function(int val) onEnded;
  const _UpcomingEventCard({
    super.key,
    required this.data,
    required this.onEnded,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpcomingEventCardState();
}

class _UpcomingEventCardState extends ConsumerState<_UpcomingEventCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width - 41;
    const double height = 189;
    return GestureDetector(
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
            SizedBox(
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.data.details.imageUrl == null ||
                          widget.data.details.imageUrl == ''
                      ? "https://firebasestorage.googleapis.com/v0/b/sat-app-b9f71.appspot.com/o/events%2FRectangle%2012.png?alt=media&token=6947e9cd-0367-404f-8252-cbe9c9200ae9"
                      : widget.data.details.imageUrl!,
                  fit: BoxFit.cover,
                  height: 120,
                  // color: Colors.black.withOpacity(0.4),
                  // colorBlendMode: BlendMode.darken,
                  width: width,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
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
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffC8C8C8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TweenAnimationBuilder<Duration>(
                        duration:
                            prettyTimeStamp3(widget.data.details.eventDate),
                        tween: Tween(
                            begin:
                                prettyTimeStamp3(widget.data.details.eventDate),
                            end: Duration.zero),
                        onEnd: () {
                          widget.onEnded(2);
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                          final days = value.inDays;
                          final hours = (value.inHours % 24) < 10
                              ? '0${(value.inHours % 24)}'
                              : (value.inHours % 24);
                          final minutes = (value.inMinutes % 60) < 10
                              ? '0${(value.inMinutes % 60)}'
                              : (value.inMinutes % 60);
                          final seconds = (value.inSeconds % 60) < 10
                              ? '0${(value.inSeconds % 60)}'
                              : (value.inSeconds % 60);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Starts in ${days != 0 ? '$days days' : ''}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '$hours : $minutes : $seconds',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoUpcomingEventCard extends ConsumerStatefulWidget {
  const _NoUpcomingEventCard({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoUpcomingEventCardState();
}

class _NoUpcomingEventCardState extends ConsumerState<_NoUpcomingEventCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width - 41;
    const double height = 189;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: scaffoldColor,
          ),
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'No Upcoming Event',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
