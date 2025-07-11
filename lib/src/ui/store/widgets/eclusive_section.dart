import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/models/reward_data.dart';
import 'package:Saturnalia/src/ui/store/widgets/show_reward_details.dart';

class ExclusiveSection extends ConsumerStatefulWidget {
  final List<RewardData> data;
  const ExclusiveSection({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeCorousalSectionState();
}

class _HomeCorousalSectionState extends ConsumerState<ExclusiveSection> {
 PageController? _pageController;
  int selectedIndex = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(Duration.zero, () {
      if (widget.data.isNotEmpty) {
        timer = Timer.periodic(const Duration(seconds: 5), (timer) {
          if (mounted) {
            setState(() {
              if (selectedIndex == widget.data.length - 1) {
                selectedIndex = 0;
              } else {
                selectedIndex++;
              }
              _pageController?.animateToPage(
                selectedIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      child: (widget.data.isEmpty)
          ? null
          : Column(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Exclusive Deals',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 130,
                  width: size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          showRewardDetailsBottomSheet(
                              context, widget.data[index]);
                        },
                        child: _ExclusiveCard(
                          data: widget.data[index],
                        ),
                      ),
                    ),
                    itemCount: widget.data.length,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}

class _ExclusiveCard extends ConsumerWidget {
  final RewardData data;
  const _ExclusiveCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        image: const DecorationImage(
            image: AssetImage('assets/images/ic_hot.png')),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                                  data.offerCoins.toString(),
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
                    ],
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: data.imageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
