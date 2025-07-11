import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/colors.dart';
import '../../../logic/repositories/store_repository/store_repository.dart';
import '../../../routing/router.dart';
import '../../../utils/project_utils.dart';
import '../../widgets/custom_text.dart';

class ShopAppBar extends ConsumerWidget {
  const ShopAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewards = ref.watch(
      storeRepositoryProvider.select((_) => _.rewards),
    );
    final count = ref.watch(
      storeRepositoryProvider.select((_) => _.itemCount),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Store',
                size: 28,
              ),
              Row(
                children: [
                  if (count != 0)
                    InkWell(
                      onTap: () {
                        context.navigateTo(const ReedemItemRoute());
                      },
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.navigateTo(const RewardHistoryRoute());
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Center(
                          child: Row(
                            children: [
                              Lottie.asset(
                                'assets/lottie/coin.json',
                                repeat: false,
                              ),
                              Text(
                                '${getTotalCoins(rewards ?? [])}',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
