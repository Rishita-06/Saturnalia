import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/routing/router.dart';
import '../../../constants/strings.dart';
import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../widgets/custom_text.dart';

class AppDrawer extends ConsumerStatefulWidget {
  final BuildContext mainContext;

  const AppDrawer({
    super.key,
    required this.mainContext,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  StreamSubscription? _subscription;
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () async {
  //     final allEvents =
  //         await ref.read(firebaseFirestoreProvider).collection('events').get();
  //     final satEvents = (allEvents.docs
  //             .map((e) => EventDetails.fromJson(e.data()))
  //             .toList())
  //         .where((element) =>
  //             element.details.eventDate.compareTo(DateTime(2023, 12, 12)) >= 0)
  //         .toList();
  //     for (EventDetails data in satEvents ?? []) {
  //       // await ref
  //       //     .read(firebaseFirestoreProvider)
  //       //     .collection('event')
  //       //     .doc('urja24')
  //       //     .collection('events')
  //       //     .doc(data.details.eventId)
  //       //     .set(data.toJson());
  //       print(data.details.title);
  //       // print(data.details.title);
  //       final dta = await ref
  //           .read(firebaseFirestoreProvider)
  //           .collection('events')
  //           .doc(data.details.eventId)
  //           .collection('users')
  //           .get();
  //       for (var datas in dta.docs) {
  //         final dt = EventUserData.fromJson(datas.data());
  //         await ref
  //             .read(firebaseFirestoreProvider)
  //             .collection('event')
  //             .doc('urja24')
  //             .collection('events')
  //             .doc(data.details.eventId)
  //             .collection('users')
  //             .doc(dt.tokenId)
  //             .set(dt.toJson());
  //         print(dt.name);
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.userName),
    );
    final isAdmin = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.roles),
        ) ??
        [];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  'Admin',
                  size: 35,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if ((isAdmin || roles.contains(4)))
                _AppDrawerCard(
                  'Scan QR',
                  icon: Icons.qr_code_2_outlined,
                  onTap: () {
                    context.maybePop();
                    widget.mainContext
                        .navigateTo(QrEventListRoute(isSearching: false));
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              if ((isAdmin ||
                  roles.contains(1) ||
                  roles.contains(2) ||
                  roles.contains(3))) ...[
                _AppDrawerCard(
                  'Manage Events',
                  icon: CupertinoIcons.calendar_badge_plus,
                  onTap: () {
                    widget.mainContext.navigateTo(const ManageEventsRoute());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if ((isAdmin || roles.contains(0))) ...[
                _AppDrawerCard(
                  'Manage Team',
                  icon: Icons.manage_accounts,
                  onTap: () {
                    context.maybePop();
                    widget.mainContext.navigateTo(const ManageTeamRoute());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if ((isAdmin || roles.contains(6))) ...[
                _AppDrawerCard(
                  'Manage Rewards',
                  icon: CupertinoIcons.gift,
                  onTap: () {
                    widget.mainContext.navigateTo(const ManageRewardsRoute());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if ((isAdmin || roles.contains(5))) ...[
                _AppDrawerCard(
                  'Manage Home Corousal',
                  icon: Icons.post_add_rounded,
                  onTap: () {
                    context.navigateTo(const EditCorousalRoute());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if ((isAdmin || roles.contains(7))) ...[
                _AppDrawerCard(
                  'Manage Polls',
                  icon: CupertinoIcons.gift,
                  onTap: () {
                    widget.mainContext.navigateTo(PollRoute(isEditing: true));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              const Expanded(child: SizedBox()),
              Text(
                userName ?? 'User',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isAdmin) ...[
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Super Admin",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Wrap(
                  children: roles
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.primaries[Random().nextInt(
                                      Colors.primaries.reversed.length)]
                                  .withOpacity(1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              child: Text(
                                team[e] ?? "Team Member",
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('exited');
    _subscription?.cancel();
  }
}

class _AppDrawerCard extends ConsumerWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  const _AppDrawerCard(
    this.name, {
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
