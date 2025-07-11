import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/manage_rewards/manage_rewards_page_model.dart';

import '../../../constants/colors.dart';

class RewardTypeSection extends ConsumerStatefulWidget {
  const RewardTypeSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardTypeSectionState();
}

class _RewardTypeSectionState extends ConsumerState<RewardTypeSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(manageRewardsPageProvider.select(
      (_) => _.isExclusive,
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reward Type',
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
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio<bool>(
                    activeColor: secondaryColor,
                    value: true,
                    groupValue: type,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return secondaryColor.withOpacity(0.5);
                      }
                      return secondaryColor;
                    }),
                    onChanged: (value) {
                      ref
                          .read(manageRewardsPageProvider.notifier)
                          .setRewardType(value ?? true);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Exclusive',
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
                  child: Radio<bool>(
                    activeColor: secondaryColor,
                    value: false,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return secondaryColor.withOpacity(0.5);
                      }
                      return secondaryColor;
                    }),
                    groupValue: type,
                    onChanged: (value) {
                      ref
                          .read(manageRewardsPageProvider.notifier)
                          .setRewardType(value ?? false);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Normal',
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
