// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/ui/manage_events/manage_event_page_model.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/repositories/events_repository/events_respository.dart';
import '../../models/event_details.dart';
import '../../routing/router.dart';
import '../../utils/toast_utils.dart';
import '../widgets/event_box.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text.dart';
import '../widgets/delete_confirmation_popup.dart';

@RoutePage()
class ManageEventsPage extends ConsumerStatefulWidget {
  const ManageEventsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends ConsumerState<ManageEventsPage> {
  final ScrollController _controller = ScrollController(initialScrollOffset: 1);
  bool isTrue = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        final upComingCount = ref.watch(
          eventsPageProvider.select(
            (_) => (_.eventList ?? [])
                .where((element) =>
                    element.details.eventDate.compareTo(
                        DateTime.now().subtract(const Duration(days: 1))) >
                    0)
                .toList()
                .length,
          ),
        );
        _controller.addListener(() {
          if (upComingCount != 0) {
            if (_controller.offset >= 220 * upComingCount && isTrue) {
              setState(() {
                isTrue = false;
              });
            }
            if (_controller.offset <= 220 * upComingCount && !isTrue) {
              setState(() {
                isTrue = true;
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.isAdmin ?? false),
    );
    final events =
        ref.watch(eventsPageProvider.select((_) => _.eventList)) ?? [];
    // print(ref.read(eventsPageProvider.select((_) => _.eventList)));

    return SafeArea(
      child: CustomScaffold(
          body: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 15),
                ),
                SliverAppBar(
                  backgroundColor: scaffoldColor,
                  elevation: 0,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  leading: null,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CustomBackButton(),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'manage',
                                style: GoogleFonts.outfit(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: ' Events',
                                style: GoogleFonts.outfit(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (events.isNotEmpty) ...[
                  SliverAppBar(
                    pinned: isTrue,
                    leading: null,
                    automaticallyImplyLeading: false,
                    backgroundColor: scaffoldColor,
                    title: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          CustomText2(
                            'Upcoming Events',
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: _EditEventBox(
                              data: events[index],
                            ),
                          ),
                          itemCount: events.length,
                        ),
                      ],
                    ),
                  ),
                ],
                // if (false) ...[
                //   SliverAppBar(
                //     pinned: !isTrue,
                //     backgroundColor: scaffoldColor,
                //     leading: null,
                //     automaticallyImplyLeading: false,
                //     title: const Padding(
                //       padding: EdgeInsets.only(left: 15),
                //       child: Row(
                //         children: [
                //           CustomText2(
                //             'Past Events',
                //             size: 16,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   SliverList(
                //     delegate: SliverChildListDelegate(
                //       [
                //         ListView.builder(
                //           physics: const NeverScrollableScrollPhysics(),
                //           shrinkWrap: true,
                //           padding: const EdgeInsets.only(bottom: 10),
                //           itemBuilder: (context, index) =>
                //               !(pastEvents[index].editors?.contains(userId) ??
                //                       false)
                //                   ? const SizedBox()
                //                   : Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           vertical: 10, horizontal: 20),
                //                       child: _EditEventBox(
                //                         data: pastEvents[index],
                //                       ),
                //                     ),
                //           itemCount: pastEvents.length,
                //         ),
                //       ],
                //     ),
                //   ),
                // ],
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: roles
              ? FloatingActionButton(
                  onPressed: () {
                    context.navigateTo(AddEventRoute());
                  },
                  child: const Icon(
                    Icons.person_add,
                    size: 26,
                  ),
                )
              : null),
    );
  }
}

class _EditEventBox extends ConsumerStatefulWidget {
  final EventDetails data;
  const _EditEventBox({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __EditEventBoxState();
}

class __EditEventBoxState extends ConsumerState<_EditEventBox> {
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;
    return Stack(
      children: [
        AllEventBox(
          onTap: () {
            context.navigateTo(ViewFormResponsesRoute(
              eventId: widget.data.details.eventId,
              eventName: widget.data.details.title,
              hasForm: widget.data.formData?.data != null,
              data: widget.data.formData,
            ));
          },
          eventData: widget.data,
          isEditing: true,
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryContainerColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    'Event Id : ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.details.eventId));
                      showSuccessMessage(context, 'Copied to Clipboard');
                    },
                    child: Text(
                      widget.data.details.eventId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (roles)
          Positioned(
            right: 15,
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                context.navigateTo(AddEventRoute(
                  eventData: widget.data,
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          right: roles ? 15 : 70,
          bottom: roles ? 50 : 55,
          child: GestureDetector(
            onTap: () {
              context.navigateTo(EventRoute(
                data: widget.data,
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Icon(
                  Icons.remove_red_eye,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        if (roles)
          Positioned(
            right: 15,
            bottom: 120,
            child: Tooltip(
              message: 'Toggle to start scanner',
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: SizedBox(
                      height: 30,
                      width: 40,
                      child: FittedBox(
                        child: CupertinoSwitch(
                            activeColor: Colors.orange,
                            value: widget.data.isFeatured,
                            onChanged: (value) async {
                              if (!isUpdating) {
                                setState(() {
                                  isUpdating = true;
                                });
                                final res = await ref
                                    .read(manageEventPageProvider.notifier)
                                    .updateFeatured(
                                        widget.data.details.eventId, value);
                                if (res != '') {
                                  showErrorMessage(context, res);
                                }
                                setState(() {
                                  isUpdating = false;
                                });
                              }
                            }),
                      ),
                    )),
              ),
            ),
          ),
        if (roles)
          Positioned(
            right: 65,
            bottom: 15,
            child: Tooltip(
              message: 'Toggle to start scanner',
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: SizedBox(
                      height: 30,
                      width: 40,
                      child: FittedBox(
                        child: CupertinoSwitch(
                            activeColor: primaryColor,
                            value: widget.data.details.scanningStarted,
                            onChanged: (value) async {
                              if (!isUpdating) {
                                setState(() {
                                  isUpdating = true;
                                });
                                final res = await ref
                                    .read(manageEventPageProvider.notifier)
                                    .updateEventScanner(
                                        widget.data.details.eventId, value, 0);
                                if (res != '') {
                                  showErrorMessage(context, res);
                                }
                                setState(() {
                                  isUpdating = false;
                                });
                              }
                            }),
                      ),
                    )),
              ),
            ),
          ),
        if (roles)
          Positioned(
            right: 15,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDeleteConfirmationPopup(
                  context,
                  title: 'Are you sure you want to delete this corousal ?',
                  onCancel: () {
                    context.maybePop();
                  },
                  isProcessing: false,
                  onConfirm: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    final res = await ref
                        .read(manageEventPageProvider.notifier)
                        .deleteEvent(widget.data.details.eventId);
                    if (res != '') {
                      showErrorMessage(context, res);
                    } else {
                      showSuccessMessage(context, 'Event deleted!');
                      context.maybePop();
                    }
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          right: 15,
          bottom: 85,
          child: Tooltip(
            message: 'Toggle to make it public or private',
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: SizedBox(
                    height: 30,
                    width: 40,
                    child: FittedBox(
                      child: CupertinoSwitch(
                          activeColor: secondaryColor,
                          value: widget.data.isPublic ?? false,
                          onChanged: (value) async {
                            if (!isUpdating) {
                              setState(() {
                                isUpdating = true;
                              });
                              final res = await ref
                                  .read(manageEventPageProvider.notifier)
                                  .updateEventVisibility(
                                      widget.data.details.eventId,
                                      value,
                                      roles ? 0 : 2);
                              if (res != '') {
                                showErrorMessage(context, res);
                              }
                              setState(() {
                                isUpdating = false;
                              });
                            }
                          }),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
