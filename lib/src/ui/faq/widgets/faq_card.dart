import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class FaqCard extends ConsumerStatefulWidget {
  final bool isExpanded;
  final bool isVisible;
  final String ques;
  final String answer;

  const FaqCard({
    super.key,
    required this.ques,
    required this.answer,
    required this.isExpanded,
    required this.isVisible,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FaqCardState();
}

class _FaqCardState extends ConsumerState<FaqCard> {
  @override
  Widget build(BuildContext context) {
    return !widget.isVisible
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff181818),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            widget.ques,
                            style: GoogleFonts.outfit(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.answer,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: widget.isExpanded
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: widget.isExpanded ? 10 : 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xff333333),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
