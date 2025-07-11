import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/notification/notification_page_model.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../constants/colors.dart';
import '../../models/notification_data.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  int? selectedNotificationId;
  bool isUnread = false;
  @override
  Widget build(BuildContext context) {
    final readNotificationlist = ref.watch(
      notificationPageProvider.select(
        (_) => _.readNotificationList,
      ),
    );
    final list = ref.watch(
      notificationPageProvider.select(
        (_) => _.notificationData,
      ),
    );

    return CustomScaffold(
      body: SafeArea(
        child: Center(
          child: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                const SliverAppBar(
                  backgroundColor: scaffoldColor,
                  elevation: 0,
                  floating: true,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      CustomBackButton(),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText2(
                        'Notifications',
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
                // if (list.length - getNotificationCount(readNotificationlist) !=
                //     0)
                SliverAppBar(
                  leading: null,
                  backgroundColor: scaffoldColor,
                  elevation: 0,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isUnread = !isUnread;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: isUnread
                                ? primaryColor
                                : const Color(0xff181818),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Unread(${list.length - getNotificationCount(readNotificationlist)}) ',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(notificationPageProvider.notifier)
                              .markAllasRead();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: list.length ==
                                    getNotificationCount(readNotificationlist)
                                ? const Color(0xff181818)
                                : primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Mark all as read',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedNotificationId == index) {
                                    setState(() {
                                      selectedNotificationId = null;
                                    });
                                  } else {
                                    setState(() {
                                      selectedNotificationId = index;
                                    });
                                  }
                                  if (!readNotificationlist.split('-').contains(
                                        list[index].id.toString(),
                                      )) {
                                    ref
                                        .read(notificationPageProvider.notifier)
                                        .markNotificationAsRead(
                                            list[index].id.toString());
                                  }
                                },
                                child: _NotificationCard(
                                  notificationData: list[index],
                                  isExpanded: selectedNotificationId == index,
                                  isVisible: !isUnread ||
                                      (isUnread &&
                                          !readNotificationlist
                                              .split('-')
                                              .contains(
                                                list[index].id.toString(),
                                              )),
                                ),
                              ),
                            ),
                            if (!readNotificationlist.split('-').contains(
                                  list[index].id.toString(),
                                ))
                              Positioned(
                                right: 20,
                                top: 10,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2187FF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                          ],
                        ),
                        itemCount: list.length,
                        shrinkWrap: true,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getNotificationCount(String ids) {
    if (ids == '') {
      return 0;
    }
    int count = 0;
    final list = ids.split('-');
    for (int i = 0; i < list.length; i++) {
      if (list[i] != '') {
        count++;
      }
    }
    return count;
  }
}

class _NotificationCard extends ConsumerStatefulWidget {
  final bool isExpanded;
  final bool isVisible;
  final NotificationData notificationData;

  const _NotificationCard({
    required this.notificationData,
    required this.isExpanded,
    required this.isVisible,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __NotificationCardState();
}

class __NotificationCardState extends ConsumerState<_NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return !widget.isVisible
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff181818),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            widget.notificationData.title,
                            style: GoogleFonts.outfit(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          prettyTimeStamp7(widget.notificationData.date),
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.notificationData.message,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: widget.isExpanded
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: widget.isExpanded ? 10 : 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xff333333),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
