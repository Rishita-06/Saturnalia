// ignore_for_file: use_build_context_synchronously
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/event_page/widgets/name_section.dart';
import 'package:Saturnalia/src/ui/event_page/widgets/tab_view_section.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../models/event_details.dart';

import '../../utils/project_utils.dart';
import '../../utils/toast_utils.dart';

import '../widgets/back_button.dart';

import 'event_page_model.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/image_banners.dart';

@RoutePage()
class EventPage extends ConsumerStatefulWidget {
  final EventDetails data;
  final bool isPreview;

  const EventPage({
    super.key,
    required this.data,
    this.isPreview = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage>
    with TickerProviderStateMixin {
  int h2 = 0;
  bool isExpanded = false;
  int attending = 0;
  int total = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      h2 = widget.isPreview
          ? 0
          : (widget.data.details.hasFormData == 3)
              ? 73
              : ((((widget.data.formData!.endDate.compareTo(DateTime.now())) <
                          0) ||
                      ((widget.data.formData!.startDate
                              .compareTo(DateTime.now())) >
                          0)))
                  ? 73
                  : 0;
      setState(() {});
      if (!widget.isPreview) {
        ref.read(eventPageProvider.notifier).getEventUserData(
              widget.data.details.eventId,
              widget.data.details.title,
            );
        if (widget.data.isInformal) {
          getCount(widget.data.details.eventId);
        }
      } else {
        ref.read(eventPageProvider.notifier).init();
      }
    });
  }

  getCount(String eventId) async {
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    final res = await ref
        .read(firebaseFirestoreProvider)
        .collection('event')
        .doc(selectedEvent)
        .collection('events')
        .doc(widget.data.details.eventId)
        .collection('users')
        .where('isAttending', isEqualTo: true)
        .count()
        .get();
    final res2 = await ref
        .read(firebaseFirestoreProvider)
        .collection('event')
        .doc(selectedEvent)
        .collection('events')
        .doc(widget.data.details.eventId)
        .collection('users')
        .count()
        .get();

    if (mounted && res2.count != 0) {
      setState(() {
        total = res2.count ?? 0;
        attending = res.count ?? 0;
      });
    }
  }

  bool scale = false;
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: containerColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    final status = ref.watch(
      eventPageProvider.select((_) => _.status),
    );

    ref.listen(eventPageProvider, (prev, next) {
      if (next.status != prev?.status) {
        if (next.status == EventStatus.verified &&
            prev?.status == EventStatus.regiesteredNotVerified) {
          showSuccessMessage(context, "QR verified");
        }
      }
    });
    final userId = ref.read(
          appRepositoryProvider.select((_) => _.userData?.userId),
        ) ??
        '';
    final isAttending =
        ref.watch(eventPageProvider.select((value) => value.isAttending));
    final eventUserData =
        ref.watch(eventPageProvider.select((value) => value.data));

    return SafeArea(
      child: Scaffold(
        body: status == EventStatus.initial ||
                status == EventStatus.loading ||
                status == EventStatus.error
            ? TryAgainWidget(
                onTap: () {
                  if (!widget.isPreview) {
                    ref.read(eventPageProvider.notifier).getEventUserData(
                          widget.data.details.eventId,
                          widget.data.details.title,
                        );
                  } else {
                    ref.read(eventPageProvider.notifier).init();
                  }
                },
                noInternet: status == EventStatus.error,
                isProcessing: status == EventStatus.initial ||
                    status == EventStatus.loading,
              )
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                  ),
                  if (widget.data.isInformal) ...[
                    AnimatedPositioned(
                      top: scale ? 135 : 0,
                      right: scale ? 290 : 0,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 700),
                      child: AnimatedScale(
                        scale: scale ? 3 : 1,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 700),
                        child: Container(
                          height: 440,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xffFA4EAB),
                                  Color(0xff401E30),
                                  Color(0xff121212),
                                ]),
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          // color: primaryColor.withOpacity(0.4),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                'assets/images/tv.png',
                                height: 400,
                                width: 350,
                              ),
                              if (widget.data.isInformal &&
                                  eventUserData != null)
                                Positioned(
                                  top: 213,
                                  left: 280,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Yes: $attending',
                                        style: GoogleFonts.lato(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'No: ${total - attending} ',
                                        style: GoogleFonts.lato(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 132,
                                left: 72,
                                child: SizedBox(
                                  height: 159,
                                  width: 180,
                                  child: ImageBanners(
                                    onTap: () {},
                                    isFeatured: widget.data.isInformal,
                                    imageList: widget.data.images,
                                  ),
                                ),
                              ),
                              if (scale &&
                                  !widget.isPreview &&
                                  eventUserData?.isAttending != isAttending)
                                Positioned(
                                  top: 198,
                                  left: 286,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (!isProcessing) {
                                        setState(() {
                                          isProcessing = true;
                                        });
                                        if (status ==
                                                EventStatus.notRegistered &&
                                            eventUserData == null) {
                                          final res = await ref
                                              .read(eventPageProvider.notifier)
                                              .registerForEvents();

                                          if (res != '') {
                                            showErrorMessage(context, res);
                                          } else {
                                            showSuccessMessage(context,
                                                'Successfully registered');
                                            setState(() {
                                              scale = false;
                                            });
                                          }
                                        } else {
                                          final res = await ref
                                              .read(eventPageProvider.notifier)
                                              .updateStatus(
                                                  eventUserData!.tokenId);

                                          if (res != '') {
                                            showErrorMessage(context, res);
                                          } else {
                                            showSuccessMessage(context,
                                                'Successfully Updated');
                                            setState(() {
                                              scale = false;
                                            });
                                          }
                                        }
                                        getCount(widget.data.details.eventId);
                                        setState(() {
                                          isProcessing = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 12,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFF3A92),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            blurRadius: 2,
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: isProcessing
                                            ? const SizedBox(
                                                width: 6,
                                                height: 6,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 0.5,
                                                ),
                                              )
                                            : Text(
                                                'Confirm',
                                                style: GoogleFonts.lato(
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (scale)
                                Positioned(
                                  top: 113,
                                  left: 255,
                                  child: Transform.scale(
                                    scale: 0.25,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (!isProcessing) {
                                          ref
                                              .read(eventPageProvider.notifier)
                                              .updateAttendingStatus(
                                                  eventUserData?.isAttending ??
                                                      false);
                                          setState(() {
                                            scale = false;
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/images/ic_back.png',
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: 143,
                                left: 276,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(eventPageProvider
                                                      .notifier)
                                                  .updateAttendingStatus(true);
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Yes',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 5,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: Container(
                                                    height: 5.8,
                                                    width: 5.8,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: isAttending
                                                          ? primaryColor
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(eventPageProvider
                                                      .notifier)
                                                  .updateAttendingStatus(false);
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 5,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 3,
                                                  ),
                                                  child: Container(
                                                    height: 5.8,
                                                    width: 5.8,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: !isAttending
                                                          ? primaryColor
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!scale) {
                                          setState(() {
                                            scale = true;
                                          });
                                        }
                                      },
                                      onHorizontalDragUpdate: (details) {
                                        if (scale) {
                                          if (details.primaryDelta != null) {
                                            if (details
                                                    .primaryDelta!.isNegative &&
                                                !isAttending) {
                                              ref
                                                  .read(eventPageProvider
                                                      .notifier)
                                                  .updateAttendingStatus(true);
                                            } else if (isAttending &&
                                                !details
                                                    .primaryDelta!.isNegative) {
                                              ref
                                                  .read(eventPageProvider
                                                      .notifier)
                                                  .updateAttendingStatus(false);
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffFF3A92),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 2),
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                blurRadius: 2,
                                              )
                                            ]),
                                        child: Center(
                                          child: Transform.rotate(
                                            angle: isAttending ? 40 : 41.6,
                                            child: Container(
                                              height: 28,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: const Color(0xff0AB3B6),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!scale)
                                Positioned(
                                  top: 95,
                                  left: 262,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Wanna Join ?',
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      ColorFiltered(
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn),
                                        child: Lottie.asset(
                                            'assets/lottie/arrow_down.json',
                                            height: 40),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else
                    SizedBox(
                      height: 380,
                      child: ImageBanners(
                        onTap: () {},
                        imageList: widget.data.images,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height +
                          h2 -
                          (widget.data.isInformal ? 450 : 370),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: scaffoldColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NameSection(
                              registrationType: widget.data.registrationType,
                              data: widget.data.details,
                              formData: widget.data.formData),
                          Expanded(
                            child: TabViewSection(
                              data: widget.data,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.data.isInformal)
                    Positioned(
                      top: 230,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: AnimatedContainer(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                          height: 30,
                          width: isExpanded ? 110 : 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondaryContainerColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Tooltip(
                                      decoration: BoxDecoration(
                                        color: secondaryContainerColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      message:
                                          'Unique id\n Will be used for registration process',
                                      triggerMode: TooltipTriggerMode.tap,
                                      textAlign: TextAlign.center,
                                      textStyle: GoogleFonts.lato(
                                        fontSize: 13,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          generateReferralCode(
                                                  widget.data.details.eventId
                                                          .substring(0, 10) +
                                                      userId.substring(0, 15),
                                                  false)
                                              .toUpperCase(),
                                          maxLines: 1,
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.white.withOpacity(0.50),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.info,
                                  color: secondaryColor,
                                  weight: 0.1,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        context.navigateTo(MapRoute(eventList: [widget.data]));
                      },
                      child: Tooltip(
                        message: 'Map',
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.map_rounded,
                            color: secondaryColor,
                            weight: 0.1,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    left: 20,
                    child: CustomBackButton(),
                  ),
                ],
              ),
        bottomNavigationBar: status == EventStatus.initial ||
                status == EventStatus.loading ||
                status == EventStatus.error
            ? null
            : !widget.isPreview &&
                    widget.data.isInformal &&
                    (status == EventStatus.notRegistered ||
                        eventUserData == null ||
                        !eventUserData.isAttending)
                ? null
                : BottomButtons(
                    key: ValueKey(widget.data.details),
                    eventData: widget.data,
                  ),
      ),
    );
  }
}
