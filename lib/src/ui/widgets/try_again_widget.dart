import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import 'custom_button.dart';
import 'custom_scaffold.dart';

class TryAgainWidget extends ConsumerStatefulWidget {
  final VoidCallback onTap;
  final bool isProcessing;
  final bool noInternet;
  const TryAgainWidget({
    super.key,
    required this.onTap,
    this.noInternet = false,
    required this.isProcessing,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TryAgainWidgetState();
}

class _TryAgainWidgetState extends ConsumerState<TryAgainWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: widget.isProcessing
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.noInternet
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                primaryColor, BlendMode.srcIn),
                            child: Lottie.asset(
                              'assets/lottie/ic_no_internet.json',
                            ),
                          )
                        : Lottie.asset(
                            'assets/lottie/ic_something_went_wrong.json',
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      widget.noInternet
                          ? 'No Internet!'
                          : 'Something\nwent wrong',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rocknRollOne(
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          width: 200,
                          onTap: widget.onTap,
                          text: 'Try Again',
                          isProcessing: widget.isProcessing,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
