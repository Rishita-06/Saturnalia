import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageContainer extends StatelessWidget {
  const ProfilePageContainer({
    super.key,
    required this.label,
    this.labelColor,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Color? labelColor;
  final Widget icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff181818),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.1),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    color: labelColor,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
