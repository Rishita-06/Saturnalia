import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../logic/repositories/events_repository/events_respository.dart';
import '../../routing/router.dart';
import '../widgets/event_box.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class UserEventsPage extends ConsumerStatefulWidget {
  const UserEventsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEventsPageState();
}

class _UserEventsPageState extends ConsumerState<UserEventsPage> {
  bool isTrue = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upComingEvents = ref.watch(
      eventsPageProvider.select(
        (_) => _.userEvents
            .where((element) =>
                element.details.eventDate.compareTo(
                    DateTime.now().subtract(const Duration(days: 1))) >
                0)
            .toList(),
      ),
    );
    final pastEvents = ref.watch(
      eventsPageProvider.select(
        (_) => _.userEvents
            .where((element) =>
                element.details.eventDate.compareTo(
                    DateTime.now().subtract(const Duration(days: 1))) <
                0)
            .toList()
            .reversed
            .toList(),
      ),
    );

    return SafeArea(
      child: CustomScaffold(
        body: ScrollConfiguration(
          behavior: NoOverscrollScrollBehavior(),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverAppBar(
                toolbarHeight: 70,
                backgroundColor: scaffoldColor,
                elevation: 0,
                floating: true,
                pinned: false,
                title: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MY',
                        style: GoogleFonts.rocknRollOne(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor,
                        ),
                      ),
                      const CustomText(
                        ' Events',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              if (upComingEvents.isEmpty && pastEvents.isEmpty) ...[
                SliverFillRemaining(
                  child: Center(
                      child: Text(
                    'No Registered Events',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                )
              ] else ...[
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 70,
                  backgroundColor: scaffoldColor,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isTrue = true;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                color: isTrue
                                    ? primaryColor
                                    : secondaryContainerColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Text(
                                    'Upcoming',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isTrue = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: !isTrue
                                    ? primaryColor
                                    : secondaryContainerColor,
                              ),
                              height: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Text(
                                    'Past',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isTrue)
                  if (upComingEvents.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: AllEventBox(
                                  onTap: () {
                                    context.navigateTo(
                                      EventRoute(data: upComingEvents[index]),
                                    );
                                  },
                                  eventData: upComingEvents[index],
                                ),
                              ),
                            ),
                            itemCount: upComingEvents.length,
                          ),
                        ],
                      ),
                    ),
                  ] else
                    SliverFillRemaining(
                      child: Center(
                          child: Text(
                        'No Upcoming Events',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    )
                else if (!isTrue)
                  if (pastEvents.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: AllEventBox(
                                  onTap: () {
                                    context.navigateTo(
                                      EventRoute(data: pastEvents[index]),
                                    );
                                  },
                                  eventData: pastEvents[index],
                                ),
                              ),
                            ),
                            itemCount: pastEvents.length,
                          ),
                        ],
                      ),
                    ),
                  ] else
                    SliverFillRemaining(
                      child: Center(
                          child: Text(
                        'No Past Events',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
