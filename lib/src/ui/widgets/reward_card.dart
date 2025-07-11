import 'package:Saturnalia/src/ui/manage_rewards/manage_rewards_page_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/models/reward_data.dart';

import '../../constants/colors.dart';
import '../../logic/repositories/app_repository/app_repository.dart';
import '../../utils/toast_utils.dart';

class RewardCard extends ConsumerStatefulWidget {
  final RewardData data;
  final bool isEditing;
  const RewardCard({
    super.key,
    required this.data,
    this.isEditing = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardCardState();
}

class _RewardCardState extends ConsumerState<RewardCard> {
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.isAdmin ?? false),
    );
    return Stack(
      children: [
        Container(
          // height: 160,
          width: 150,
          decoration: BoxDecoration(
            color: secondaryContainerColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: widget.data.imageUrl,
                    fit: BoxFit.cover,
                    height: 130,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    children: [
                      Text(
                        widget.data.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/lottie/coin.json',
                            repeat: false,
                            height: 30,
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            widget.data.coins.toString(),
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColor,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (roles && widget.isEditing)
          Positioned(
            right: 10,
            top: 5,
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
                            value: widget.data.isPublic,
                            onChanged: (value) async {
                              if (!isUpdating) {
                                setState(() {
                                  isUpdating = true;
                                });
                                final res = await ref
                                    .read(manageRewardsPageProvider.notifier)
                                    .updateRewardVisibility(
                                        widget.data.id, value);
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
