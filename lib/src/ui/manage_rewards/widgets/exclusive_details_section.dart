import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_text_field.dart';
import '../manage_rewards_page_model.dart';

class ExclusiveDetailsSection extends ConsumerStatefulWidget {
  const ExclusiveDetailsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExclusiveDetailsSectionState();
}

class _ExclusiveDetailsSectionState
    extends ConsumerState<ExclusiveDetailsSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(manageRewardsPageProvider.select(
      (_) => _.isExclusive,
    ));
    return Column(
      children: [
        if (type) ...[
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            hintText: 'Enter offer value',
            label: 'Offer Coins',
            onChanged: (value) {
              ref
                  .read(manageRewardsPageProvider.notifier)
                  .setOfferCoins(int.parse(value == '' ? '0' : value));
            },
            isDigitOnly: true,
            initialText: '',
            maxLength: 5,
          ),
        ] else
          const SizedBox(
            height: 15,
          ),
      ],
    );
  }
}
