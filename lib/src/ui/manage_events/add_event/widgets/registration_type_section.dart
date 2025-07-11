import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../add_event_model.dart';

class RegistrationTypeSection extends ConsumerStatefulWidget {
  const RegistrationTypeSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationTypeSectionState();
}

class _RegistrationTypeSectionState
    extends ConsumerState<RegistrationTypeSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(
      addEventModelProvider.select((_) => _.registrationType),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Registration Type',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // Row(
            //   children: [
            //     Radio<int>(
            //       activeColor: primaryColor,
            //       value: 1,
            //       groupValue: type,
            //       fillColor: MaterialStateProperty.resolveWith<Color>(
            //           (Set<MaterialState> states) {
            //         if (states.contains(MaterialState.disabled)) {
            //           return primaryColor.withOpacity(0.5);
            //         }
            //         return primaryColor;
            //       }),
            //       onChanged: (value) {
            //         ref
            //             .read(addEventModelProvider.notifier)
            //             .setRegistrationType(value);
            //       },
            //     ),
            //     Text(
            //       'Direct',
            //       style: GoogleFonts.outfit(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 2,
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
                        .read(addEventModelProvider.notifier)
                        .setRegistrationType(value);
                  },
                ),
                Text(
                  'Form',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  activeColor: primaryColor,
                  value: 3,
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
                        .read(addEventModelProvider.notifier)
                        .setRegistrationType(value);
                  },
                ),
                Text(
                  'Not Decided Yet',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
