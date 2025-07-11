import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class CustomText extends ConsumerWidget {
  final String text;
  final Color color;
  final double? size;

  const CustomText(
    this.text, {
    super.key,
    this.color = secondaryColor,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: GoogleFonts.rocknRollOne(
                fontSize: size,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
            const SizedBox(
              width: 50,
            )
          ],
        ),
        Image.asset(
          'assets/images/ic_text.png',
          height: 28,
        ),
      ],
    );
  }
}

class CustomText2 extends ConsumerWidget {
  final String text;
  final Color color;
  final double? size;

  const CustomText2(
    this.text, {
    super.key,
    this.color = secondaryColor,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.rocknRollOne(
            fontSize: size,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          'assets/images/ic_text2.png',
          height: 30,
        ),
      ],
    );
  }
}

class CustomBulletText extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  const CustomBulletText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 3),
          child: Icon(
            Icons.fiber_manual_record, // You can use any bullet point icon
            size: 12.0,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            text,
            style: style ??
                GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,

                ),
          ),
        ),
      ],
    );
  }
}
