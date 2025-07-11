import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/logic/repositories/store_repository/store_repository.dart';
import 'package:Saturnalia/src/ui/store/widgets/show_reward_details.dart';

import '../../widgets/reward_card.dart';

class RewardsSection extends ConsumerStatefulWidget {
  const RewardsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamesSectionState();
}

class _GamesSectionState extends ConsumerState<RewardsSection> {
  @override
  Widget build(BuildContext context) {
    final rewardsList = ref.watch(storeRepositoryProvider.select((value) =>
        value.publicRewardsList?.where((element) => !element.isExclusive)));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rewards',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          rewardsList!.isEmpty
              ? SizedBox(
                  height: 170,
                  child: Center(
                    child: Text(
                      'No Prizes Yet',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceEvenly,
                    children: rewardsList
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                showRewardDetailsBottomSheet(context, e);
                              },
                              child: RewardCard(data: e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
