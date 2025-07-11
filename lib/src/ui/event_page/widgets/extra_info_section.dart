import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

class ExtraInfoSection extends ConsumerStatefulWidget {
  final String desc;
  final String title;

  const ExtraInfoSection({
    super.key,
    required this.desc,
    required this.title,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoSectionState();
}

class _InfoSectionState extends ConsumerState<ExtraInfoSection> {
  bool showScrollHint = false;
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(Duration.zero, () {
      if ((_scrollController?.position.maxScrollExtent ?? 0) > 0.0) {
        setState(() {
          showScrollHint = true;
        });
      }
      _scrollController?.addListener(() {
        if ((_scrollController?.position.pixels.floor() ?? 0) >=
            (_scrollController?.position.maxScrollExtent.floor() ?? 0)) {
          setState(() {
            showScrollHint = false;
          });
        } else {
          setState(() {
            showScrollHint = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        ScrollConfiguration(
          behavior: NoOverscrollScrollBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.desc,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.50),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        if (showScrollHint)
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 50,
              child: Align(
                alignment: Alignment.center,
                child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    child: Lottie.asset('assets/lottie/arrow_down.json',
                        height: 50)),
              ),
            ),
          ),
      ],
    );
  }
}
