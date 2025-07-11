import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/constants/strings.dart';

import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import 'manage_team_page_model.dart';
import 'widgets/add_member.dart';
import 'widgets/team_details_page.dart';

@RoutePage()
class ManageTeamPage extends ConsumerStatefulWidget {
  const ManageTeamPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageTeamPageState();
}

class _ManageTeamPageState extends ConsumerState<ManageTeamPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final lists =
        ref.watch(manageTeamPageProvider.select((value) => value.team));
    final status =
        ref.watch(manageTeamPageProvider.select((value) => value.status));
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;
    return SafeArea(
      child: CustomScaffold(
        body: status == ManageTeamStatus.loaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CustomBackButton(),
                        SizedBox(width: 10),
                        CustomText2(
                          'Manage Team',
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: containerColor,
                    height: 45,
                    child: TabBar(
                      isScrollable: false,
                      dividerColor: primaryColor,
                      tabs: [
                        ...teams.keys.skipWhile((value) => value == 0).map(
                              (e) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    teams[e] ?? 'Team',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                      controller: _tabController,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: teams.keys
                          .skipWhile((value) => value == 0)
                          .map(
                            (e) => TeamsDetailsPage(
                              // isRemovable: (roleId < e &&
                              //     teams.keys
                              //             .where((element) => element > roleId)
                              //             .length >=
                              //         2),
                              isRemovable: roles,
                              data: lists!.where((_) => _.roleId == e).toList()
                                ..sort(
                                  (a, b) => a.userName.compareTo(b.userName),
                                ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              )
            : TryAgainWidget(
                onTap: () {
                  ref.read(manageTeamPageProvider.notifier).init();
                },
                noInternet: status == ManageTeamStatus.error,
                isProcessing: status == ManageTeamStatus.initial ||
                    status == ManageTeamStatus.loading,
              ),
        floatingActionButton: status == ManageTeamStatus.loaded
            ? roles
                ? FloatingActionButton(
                    onPressed: () {
                      showAddMemberBottomSheet(context);
                    },
                    child: const Icon(
                      Icons.person_add,
                      size: 26,
                    ),
                  )
                : null
            : null,
      ),
    );
  }
}
