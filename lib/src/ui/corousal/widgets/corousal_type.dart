import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/corousal/edit_corousal_page_model.dart';

import '../../../constants/colors.dart';

class CorousalTypeSection extends ConsumerStatefulWidget {
  const CorousalTypeSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CorousalTypeSectionState();
}

class _CorousalTypeSectionState extends ConsumerState<CorousalTypeSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(
      corousalPageProvider.select(
        (_) => _.corousalType,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Corousal Type (Redirect to)',
          style: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 0,
                  groupValue: type,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return primaryColor.withOpacity(0.5);
                    }
                    return primaryColor;
                  }),
                  onChanged: (value) {
                    ref
                        .read(corousalPageProvider.notifier)
                        .setCorousalType(value);
                  },
                ),
                Text(
                  'External Link',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 1,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return primaryColor.withOpacity(0.5);
                    }
                    return primaryColor;
                  }),
                  groupValue: type,
                  onChanged: (value) {
                    ref
                        .read(corousalPageProvider.notifier)
                        .setCorousalType(value);
                  },
                ),
                Text(
                  'Event',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 2,
                  groupValue: type,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return primaryColor.withOpacity(0.5);
                    }
                    return primaryColor;
                  }),
                  onChanged: (value) {
                    ref.read(corousalPageProvider.notifier).setCorousalType(2);
                  },
                ),
                Text(
                  'Poll',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 3,
                  groupValue: type,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return primaryColor.withOpacity(0.5);
                    }
                    return primaryColor;
                  }),
                  onChanged: (value) {
                    ref.read(corousalPageProvider.notifier).setCorousalType(3);
                  },
                ),
                Text(
                  'No Link',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
