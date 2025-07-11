import 'package:Saturnalia/src/ui/event_page/widgets/extra_info_section.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/ui/event_page/widgets/info_section.dart';

class TabViewSection extends ConsumerStatefulWidget {
  final EventDetails data;
  const TabViewSection({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabViewSectionState();
}

class _TabViewSectionState extends ConsumerState<TabViewSection>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    int count = 2;
    if (widget.data.timeLineData != null) {
      count++;
    }
    if (widget.data.details.registrationProcess.trim().isNotEmpty) {
      count++;
    }
    if (widget.data.details.rulesAndRegulation.trim().isNotEmpty) {
      count++;
    }
    if (widget.data.details.termsAndCondition.trim().isNotEmpty) {
      count++;
    }
    if (widget.data.details.pointOfContact.trim().isNotEmpty) {
      count++;
    }
    _tabController = TabController(length: count, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              labelColor: secondaryColor,
              indicatorColor: Colors.transparent,
              labelStyle: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: secondaryColor,
              ),
              controller: _tabController,
              tabs: [
                const SizedBox(
                  height: 30,
                  child: Tab(
                    text: 'Event Info',
                  ),
                ),
                if (widget.data.timeLineData != null)
                  const SizedBox(
                    height: 30,
                    child: Tab(
                      text: 'Timeline',
                    ),
                  ),
                if (widget.data.details.registrationProcess.trim().isNotEmpty)
                  const SizedBox(
                    height: 30,
                    child: Tab(
                      text: 'Registration',
                    ),
                  ),
                if (widget.data.details.rulesAndRegulation.trim().isNotEmpty)
                  const SizedBox(
                    height: 30,
                    child: Tab(
                      text: 'Rules',
                    ),
                  ),
                if (widget.data.details.termsAndCondition.trim().isNotEmpty)
                  const SizedBox(
                    height: 30,
                    child: Tab(
                      text: 'T & C',
                    ),
                  ),
                if (widget.data.details.pointOfContact.trim().isNotEmpty)
                  const SizedBox(
                    height: 30,
                    child: Tab(
                      text: 'POC',
                    ),
                  ),
                const SizedBox(
                  height: 30,
                  child: Tab(
                    text: 'Prizes',
                  ),
                ),
              ]),
          const Divider(
            color: secondaryContainerColor,
            thickness: 1.5,
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                InfoSection(
                  data: widget.data,
                ),
                if (widget.data.timeLineData != null)
                  const Center(child: Text('will be released soon')),
                if (widget.data.details.registrationProcess.trim().isNotEmpty)
                  ExtraInfoSection(
                      title: 'Registration Process',
                      desc: widget.data.details.registrationProcess.trim()),
                if (widget.data.details.rulesAndRegulation.trim().isNotEmpty)
                  ExtraInfoSection(
                      title: 'Rules and Regulations',
                      desc: widget.data.details.rulesAndRegulation.trim()),
                if (widget.data.details.termsAndCondition.trim().isNotEmpty)
                  ExtraInfoSection(
                      title: 'Terms and Conditions',
                      desc: widget.data.details.termsAndCondition.trim()),
                if (widget.data.details.pointOfContact.trim().isNotEmpty)
                  ExtraInfoSection(
                      title: 'Point Of Contact',
                      desc: widget.data.details.pointOfContact.trim()),
                widget.data.priceData != null &&
                        widget.data.priceData!.isNotEmpty
                    ? ScrollConfiguration(
                        behavior: NoOverscrollScrollBehavior(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data.priceData?.length,
                          padding: const EdgeInsets.only(top: 10, bottom: 100),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                height: 75,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: secondaryContainerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.asset(index % 2 == 0
                                            ? 'assets/images/ic_win.png'
                                            : 'assets/images/ic_win2.png'),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.data.priceData![index]
                                                    .title,
                                                style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                                      .withOpacity(0.50),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Prizes Worth ₹ ${widget.data.priceData![index].value}',
                                                style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text('Prizes will be announced soon!'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
