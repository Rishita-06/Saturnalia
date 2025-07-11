// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/manage_rewards/widgets/details_section.dart';
import 'package:Saturnalia/src/ui/manage_rewards/widgets/exclusive_details_section.dart';
import 'package:Saturnalia/src/ui/manage_rewards/widgets/reward_type_section.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../../constants/colors.dart';

import '../../../models/reward_data.dart';
import '../../../utils/toast_utils.dart';
import '../../widgets/add_date_section.dart';
import '../../widgets/back_button.dart';
import '../../widgets/corousal_widget.dart';
import '../../widgets/custom_text.dart';
import '../manage_rewards_page_model.dart';

@RoutePage()
class AddRewardsPage extends ConsumerStatefulWidget {
  final RewardData? data;
  const AddRewardsPage({
    super.key,
    this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddRewardsPageState();
}

class _AddRewardsPageState extends ConsumerState<AddRewardsPage> {
  bool isProcessing = false;
  bool isProcessing1 = false;
  @override
  Widget build(BuildContext context) {
    ref.listen(manageRewardsPageProvider, (prev, next) {
      if (prev?.imageUrl != next.imageUrl) {
        if (next.imageUrl.trim().isNotEmpty) {
          setState(() {
            isProcessing = false;
          });
        }
      }
    });

    final status =
        ref.watch(manageRewardsPageProvider.select((value) => value.status));
    final bannerUrl =
        ref.watch(manageRewardsPageProvider.select((value) => value.imageUrl));
    final date =
        ref.watch(manageRewardsPageProvider.select((value) => value.validTill));
    return WillPopScope(
      onWillPop: () async {
        ref.read(manageRewardsPageProvider.notifier).clearData();
        return true;
      },
      child: SafeArea(
        child: CustomScaffold(
          body: status == ManageRewardsPageStatus.loaded
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollScrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              CustomBackButton(),
                              SizedBox(width: 10),
                              CustomText2(
                                'Add Rewards',
                                size: 28,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Reward Image',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (bannerUrl.trim().isNotEmpty) ...[
                            Stack(
                              children: [
                                CorousalWidget(
                                  imageUrl: bannerUrl,
                                  height: 160,
                                  width: 115,
                                ),
                                if (widget.data == null)
                                  Positioned(
                                    top: 15,
                                    left: 110,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!isProcessing || !isProcessing1) {
                                          ref
                                              .read(manageRewardsPageProvider
                                                  .notifier)
                                              .setBannerUrl('');
                                        }
                                      },
                                      child: const Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ] else ...[
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                if (!(isProcessing || isProcessing1)) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  final res = await ref
                                      .read(manageRewardsPageProvider.notifier)
                                      .pickFile();
                                  if (res != '') {
                                    showErrorMessage(context, res);
                                    setState(() {
                                      isProcessing = false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryContainerColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 120,
                                width: 120,
                                child: isProcessing
                                    ? Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white.withOpacity(0.6),
                                          size: 40,
                                        ),
                                      ),
                              ),
                            )
                          ],
                          const DetailsSection(
                            key: ValueKey(1),
                          ),
                          AddDateSection(
                            onTap: () {
                              return true;
                            },
                            label: 'Reward Open Till',
                            onChanged: (value) {
                              ref
                                  .read(manageRewardsPageProvider.notifier)
                                  .setValidTillDate(value);
                            },
                            dateTime: date,
                          ),
                          const SizedBox(height: 25),
                          const RewardTypeSection(),
                          const ExclusiveDetailsSection(
                            key: ValueKey(2),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomButton(
                              onTap: () async {
                                if (isProcessing || isProcessing1) {
                                  return;
                                }
                                setState(() {
                                  isProcessing1 = true;
                                });
                                final res = await ref
                                    .read(manageRewardsPageProvider.notifier)
                                    .addReward();
                                if (res != '') {
                                  showErrorMessage(context, res);
                                  setState(() {
                                    isProcessing1 = false;
                                  });
                                } else {
                                  showSuccessMessage(
                                      context, 'Rewarded added successfully!');
                                  context.maybePop();
                                }
                              },
                              text: 'Add Reward',
                              isProcessing: isProcessing1,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : TryAgainWidget(
                  onTap: () {},
                  isProcessing: status == ManageRewardsPageStatus.initial ||
                      status == ManageRewardsPageStatus.loading,
                ),
        ),
      ),
    );
  }
}
