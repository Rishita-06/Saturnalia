import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_text_field.dart';
import '../manage_rewards_page_model.dart';

class DetailsSection extends ConsumerStatefulWidget {
  const DetailsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeatilsSectionState();
}

class _DeatilsSectionState extends ConsumerState<DetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Enter reward name',
          label: 'Reward',
          onChanged: (value) {
            ref.read(manageRewardsPageProvider.notifier).setRewardName(value);
          },
          initialText: '',
          maxLength: null,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'description',
          label: 'Descrption(optional)',
          onChanged: (value) {
            ref.read(manageRewardsPageProvider.notifier).setDescription(value);
          },
          initialText: '',
          maxlines: null,
          maxLength: null,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Enter rewards coins',
          label: 'Reward Coins',
          onChanged: (value) {
            ref
                .read(manageRewardsPageProvider.notifier)
                .setCoin(int.parse(value == '' ? '0' : value));
          },
          isDigitOnly: true,
          initialText: '',
          maxLength: 5,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Enter quantity',
          label: 'Quantity',
          onChanged: (value) {
            ref
                .read(manageRewardsPageProvider.notifier)
                .setQuantity(int.parse(value == '' ? '0' : value));
          },
          isDigitOnly: true,
          initialText: '',
          maxLength: 3,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Enter original value(in Rs.)',
          label: 'Original Value',
          onChanged: (value) {
            ref
                .read(manageRewardsPageProvider.notifier)
                .setOriginalValue(int.parse(value == '' ? '0' : value));
          },
          isDigitOnly: true,
          initialText: '',
          maxLength: 7,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
