import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/notification/notification_page_model.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../main/main_page.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  const HomeAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final hasNewNotification = ref.watch(
      notificationPageProvider.select((_) =>
          _.notificationData.length >
          getNotificationCount(_.readNotificationList)),
    );
    final isAdmin = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.roles),
        ) ??
        [];
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              height: 40,
              width: 60,
              decoration: !(isAdmin || roles.isNotEmpty)
                  ? null
                  : const BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
              child: !(isAdmin || roles.isNotEmpty)
                  ? null
                  : const Center(
                      child: Icon(
                        Icons.menu,
                        color: primaryColor,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 1,
                  heightFactor: 0.45,
                  child: Image.asset(
                    'assets/images/sat_logo.png',
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.navigateTo(const NotificationRoute()),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/ic_notification.png',
                  height: 50,
                  width: 50,
                ),
                if (hasNewNotification)
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xff2187FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
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
