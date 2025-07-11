import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Saturnalia/src/logic/repositories/store_repository/store_repository.dart';

import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/ui/widgets/reward_card.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';

import 'manage_rewards_page_model.dart';

@RoutePage()
class ManageRewardsPage extends ConsumerStatefulWidget {
  const ManageRewardsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageRewardsPageState();
}

class _ManageRewardsPageState extends ConsumerState<ManageRewardsPage> {
  @override
  Widget build(BuildContext context) {
    final status =
        ref.watch(manageRewardsPageProvider.select((value) => value.status));
    final rewards =
        ref.watch(storeRepositoryProvider.select((value) => value.rewardsList));

    return SafeArea(
      child: CustomScaffold(
        body: status == ManageRewardsPageStatus.loaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'Manage Rewards',
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: rewards!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: RewardCard(
                                data: e,
                                isEditing: true,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              )
            : TryAgainWidget(
                onTap: () {
                  ref.read(storeRepositoryProvider.notifier).getRewardsList();
                },
                isProcessing: status == ManageRewardsPageStatus.initial ||
                    status == ManageRewardsPageStatus.loading,
              ),
        floatingActionButton: status == ManageRewardsPageStatus.loaded
            ? FloatingActionButton(
                onPressed: () {
                  context.navigateTo(AddRewardsRoute());
                },
                child: const Icon(
                  Icons.person_add,
                  size: 26,
                ),
              )
            : null,
      ),
    );
  }
}
