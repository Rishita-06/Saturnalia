import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import 'package:Saturnalia/src/ui/create/create_account_page_model.dart';

class GenderSection extends ConsumerStatefulWidget {
  const GenderSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenderSectionState();
}

class _GenderSectionState extends ConsumerState<GenderSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(createAccountPageProvider.select(
      (_) => _.gender,
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio<int>(
                    activeColor: secondaryColor,
                    value: 1,
                    groupValue: type,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return secondaryColor.withOpacity(0.5);
                      }
                      return secondaryColor;
                    }),
                    onChanged: (value) {
                      ref.read(createAccountPageProvider.notifier).setGender(1);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Male',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio<int>(
                    activeColor: secondaryColor,
                    value: 2,
                    groupValue: type,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return secondaryColor.withOpacity(0.5);
                      }
                      return secondaryColor;
                    }),
                    onChanged: (value) {
                      ref.read(createAccountPageProvider.notifier).setGender(2);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Female',
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
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Radio<int>(
                activeColor: Colors.black,
                value: 3,
                groupValue: type,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return secondaryColor.withOpacity(0.5);
                  }
                  return secondaryColor;
                }),
                onChanged: (value) {
                  ref.read(createAccountPageProvider.notifier).setGender(3);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Prefer Not To Say',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
