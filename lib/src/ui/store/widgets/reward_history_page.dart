import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';

import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../../logic/repositories/store_repository/store_repository.dart';
import '../../../models/reward_points_data.dart';
import '../../widgets/custom_text.dart';

@RoutePage()
class RewardHistoryPage extends ConsumerStatefulWidget {
  const RewardHistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardHistoryPageState();
}

class _RewardHistoryPageState extends ConsumerState<RewardHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final rewards = ref.watch(
          storeRepositoryProvider.select((_) => _.rewards),
        ) ??
        [];
    return SafeArea(
      child: CustomScaffold(
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Row(
              children: [
                CustomBackButton(),
                SizedBox(
                  width: 10,
                ),
                CustomText2(
                  'Rewards History',
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/coin2.json',
                    height: 60,
                  ),
                  Text(
                    '${getTotalCoins(rewards)}',
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                'Available Coins',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: CustomText2(
              //       'History',
              //       color: Colors.white,
              //       size: 25,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Earned Coins : ',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${getEarnedCoins(rewards)}',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Debited Coins : ',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${getDebitedCoins(rewards)}',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff181818),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Divider(
                            color: rewards.isEmpty
                                ? const Color(0xff181818)
                                : Colors.white,
                          ),
                          rewards.isEmpty
                              ? SizedBox(
                                  height: 400,
                                  child: Center(
                                    child: Text(
                                      'No Rewards\nRegister in events to get rewards',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: rewards
                                      .map(
                                        (e) => GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            if (e.isAwarded == 0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: primaryColor,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  content: Text(
                                                    'This reward will be credited when you successfully attend the event!',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e.title,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: GoogleFonts
                                                                .outfit(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                prettyTimeStamp9(e
                                                                    .date
 ),
                                                                style:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                height: 5,
                                                                width: 5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: e.isAwarded ==
                                                                          1
                                                                      ? Colors
                                                                          .green
                                                                      : e.isAwarded ==
                                                                              0
                                                                          ? Colors
                                                                              .orange
                                                                          : Colors
                                                                              .red,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                e.isAwarded == 1
                                                                    ? "Added"
                                                                    : e.isAwarded ==
                                                                            0
                                                                        ? 'Pending'
                                                                        : 'Debited',
                                                                style:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: e.isAwarded ==
                                                                          1
                                                                      ? Colors
                                                                          .green
                                                                      : e.isAwarded ==
                                                                              0
                                                                          ? Colors
                                                                              .orange
                                                                          : Colors
                                                                              .red,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      '${e.isAwarded == 2 ? '-' : '+'} ${e.coins}',
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 18,
                                                        color: e.isAwarded == 1
                                                            ? Colors.green
                                                            : e.isAwarded == 0
                                                                ? Colors.orange
                                                                : Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  int getTotalCoins(List<RewardPointsData> data) {
    if (data.isEmpty) {
      return 0;
    }
    int coins = 0;
    for (RewardPointsData reward in data) {
      if (reward.isAwarded == 0) {
      } else if (reward.isAwarded == 1) {
        coins += reward.coins;
      } else {
        coins -= reward.coins;
      }
    }
    return coins;
  }

  int getEarnedCoins(List<RewardPointsData> data) {
    if (data.isEmpty) {
      return 0;
    }
    int coins = 0;
    for (RewardPointsData reward in data) {
      if (reward.isAwarded == 0) {
      } else if (reward.isAwarded == 1) {
        coins += reward.coins;
      }
    }
    return coins;
  }

  int getDebitedCoins(List<RewardPointsData> data) {
    if (data.isEmpty) {
      return 0;
    }
    int coins = 0;
    for (RewardPointsData reward in data) {
      if (reward.isAwarded == 0) {
      } else if (reward.isAwarded == 1) {
      } else {
        coins += reward.coins;
      }
    }
    return coins;
  }
}
