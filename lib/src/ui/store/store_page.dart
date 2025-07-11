import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Saturnalia/src/ui/store/widgets/rewards_section.dart';
import 'package:Saturnalia/src/ui/store/widgets/eclusive_section.dart';
import 'package:Saturnalia/src/ui/store/widgets/top_bar.dart';

import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/repositories/store_repository/store_repository.dart';
import 'widgets/leaderboard_card.dart';

@RoutePage()
class StorePage extends ConsumerStatefulWidget {
  const StorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends ConsumerState<StorePage> {
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      storeRepositoryProvider.select((_) => _.status),
    );
    final rewardsList = ref
            .watch(storeRepositoryProvider.select((value) => value
                .publicRewardsList
                ?.where((element) => element.isExclusive)))
            ?.toList() ??
        [];

    final rewardsCount = ref
            .watch(storeRepositoryProvider
                .select((value) => value.publicRewardsList))
            ?.length ??
        0;
    return SafeArea(
      child: CustomScaffold(
        body: status == StorePageStatus.loaded
            ? ScrollConfiguration(
                behavior: NoOverscrollScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const ShopAppBar(),
                      const SizedBox(height: 20),
                      const LeaderboardCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const GamesCard(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (rewardsCount != 0) ...[
                        ExclusiveSection(
                          data: rewardsList,
                        ),
                        const SizedBox(height: 20),
                        const RewardsSection(),
                        const SizedBox(height: 50),
                      ] else ...[
                        SizedBox(
                          height: 400,
                          child: Center(
                            child: Text(
                              'Store Coming Soon!',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.51),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              )
            : TryAgainWidget(
                onTap: () async {
                  ref
                      .read(storeRepositoryProvider.notifier)
                      .getUserRewardsList();
                },
                isProcessing: status == StorePageStatus.loading ||
                    status == StorePageStatus.initial,
              ),
      ),
    );
  }
}
