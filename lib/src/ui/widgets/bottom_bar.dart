// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isAndroid ? 85 : 100,
      decoration: const BoxDecoration(
        color: containerColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(6, 0),
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 10,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
                top: 5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavigationBarItem(
                    imagePath: 'assets/images/ic_home.png',
                    isActive: context.tabsRouter.activeIndex == 0,
                    title: 'Home',
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.tabsRouter.setActiveIndex(0);
                    },
                  ),
                  _NavigationBarItem(
                    imagePath: 'assets/images/ic_calender.png',
                    title: 'Calendar',
                    isActive: context.tabsRouter.activeIndex == 1,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      // if (!await hasInternetAccess()) {
                      //   context.navigateTo(NoInternetRoute(onChanged: (bools) {
                      //     if (bools) {
                      //       context.maybePop();
                      //     }
                      //   }));
                      // }

                      context.tabsRouter.setActiveIndex(1);
                    },
                  ),
                  _NavigationBarItem(
                    imagePath: 'assets/images/ic_store.png',
                    title: 'Shop',
                    isActive: context.tabsRouter.activeIndex == 2,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      // if (!await hasInternetAccess()) {
                      //   context.navigateTo(NoInternetRoute(onChanged: (bools) {
                      //     if (bools) {
                      //       context.maybePop();
                      //     }
                      //   }));
                      // }
                      context.tabsRouter.setActiveIndex(2);
                    },
                  ),
                  _NavigationBarItem(
                    imagePath: 'assets/images/ic_event.png',
                    title: 'My Events',
                    isActive: context.tabsRouter.activeIndex == 3,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      // if (!await hasInternetAccess()) {
                      //   context.navigateTo(NoInternetRoute(onChanged: (bools) {
                      //     if (bools) {
                      //       context.maybePop();
                      //     }
                      //   }));
                      // }
                      context.tabsRouter.setActiveIndex(3);
                    },
                  ),
                  _NavigationBarItem(
                    imagePath: 'assets/images/ic_profile.png',
                    title: 'Profile',
                    isActive: context.tabsRouter.activeIndex == 4,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      // if (!await hasInternetAccess()) {
                      //   context.navigateTo(NoInternetRoute(onChanged: (bools) {
                      //     if (bools) {
                      //       context.maybePop();
                      //     }
                      //   }));
                      // }
                      context.tabsRouter.setActiveIndex(4);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  final bool isActive;
  final String imagePath;
  final VoidCallback onTap;
  final String title;

  const _NavigationBarItem({
    required this.isActive,
    required this.imagePath,
    required this.onTap,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive ? primaryColor : primaryColor.withOpacity(0.3);

    return SizedBox(
      width: 65,
      height: 48,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              color: color,
              height: isActive ? 30 : 27,
              width: isActive ? 30 : 27,
            ),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
