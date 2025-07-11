import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class CustomButton extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool isProcessing;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.isProcessing,
    this.width = 250,
    this.height = 50,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends ConsumerState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(minWidth: widget.width),
        height: widget.height,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              spreadRadius: 0,
              color: primaryColor,
            )
          ],
        ),
        child: Center(
          child: widget.isProcessing
              ? const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: FittedBox(
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rocknRollOne(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
