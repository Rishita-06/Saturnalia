import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:Saturnalia/src/routing/router.dart';

import '../../../utils/container_utils.dart';
import '../../../utils/web_utils.dart';
import '../../../models/corousal_data.dart';

class HomeCorousalSection extends ConsumerStatefulWidget {
  final List<CorousalData> data;
  const HomeCorousalSection({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeCorousalSectionState();
}

class _HomeCorousalSectionState extends ConsumerState<HomeCorousalSection> {
  late final PageController _pageController;
  int selectedIndex = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          if (selectedIndex == widget.data.length - 1) {
            selectedIndex = 0;
          } else {
            selectedIndex++;
          }
          _pageController.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 230,
                width: size.width,
                child: PageView.builder(
                  controller: _pageController,
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.data[index].link != null &&
                            widget.data[index].corousalType == 0) {
                          openUrl(widget.data[index].link ?? '');
                        } else if (widget.data[index].eventId != null &&
                            widget.data[index].corousalType == 1) {
                          try {
                            final eventData = ref.read(
                                eventsPageProvider.select((_) =>
                                    _.allPublicEvents?.firstWhere((e) =>
                                        e.details.eventId ==
                                        widget.data[index].eventId)));
                            if (eventData != null) {
                              context.navigateTo(EventRoute(data: eventData));
                            }
                          } catch (e) {}
                        } else if (widget.data[index].corousalType == 2) {
                          context.navigateTo(PollRoute(isEditing: false));
                        }
                      },
                      child: Stack(
                        children: [
                          ClipPath(
                            clipper: (widget.data[index].corousalType == 0 ||
                                    widget.data[index].corousalType == 1)
                                ? CustomPath()
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: containerColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.data[index].imageUrl,
                                  height: 210,
                                  width: MediaQuery.sizeOf(context).width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          if (widget.data[index].corousalType == 0 ||
                              widget.data[index].corousalType == 1)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: ClipPath(
                                clipper: CustomPath2(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    color: secondaryColor,
                                  ),
                                  height: 31,
                                  width: 144,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Center(
                                        child: Text(
                                      widget.data[index].eventId?.trim() != null
                                          ? 'Register Now >'
                                          : "Visit Here >",
                                      style: GoogleFonts.rocknRollOne(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: widget.data.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
