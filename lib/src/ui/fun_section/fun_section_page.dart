import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class FunSectionPage extends ConsumerStatefulWidget {
  const FunSectionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FunSectionPageState();
}

class _FunSectionPageState extends ConsumerState<FunSectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CustomBackButton(),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText2(
                        'Fun Zone',
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _FunCard(
                    title: 'Vote & Win!',
                    image: 'assets/images/vote.png',
                    subTitle:
                        'Tap for laughs and coins! Your vote counts, and so does your fun factor. 🗳️💰',
                    onTap: () {
                      context.navigateTo(PollRoute(
                        isEditing: false,
                      ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _FunCard(
                    title: 'Unlock Treasures!',
                    image: 'assets/images/tresure.png',
                    subTitle:
                        'Fill the Pockets! Redeem exclusive codes for a coin bonanza. 💰✨',
                    onTap: () {
                      showSuccessMessage(context, 'Coming Soon!');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FunCard extends ConsumerStatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final String image;
  const _FunCard({
    super.key,
    required this.onTap,
    this.image = '',
    required this.subTitle,
    required this.title,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FunCardState();
}

class __FunCardState extends ConsumerState<_FunCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: secondaryContainerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.asset(
                  widget.image.trim().isEmpty
                      ? 'assets/images/login.png'
                      : widget.image,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.subTitle,
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
