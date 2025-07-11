import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/back_button.dart';

import '../widgets/custom_text.dart';

@RoutePage()
class ReedemCodePage extends ConsumerStatefulWidget {
  const ReedemCodePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReedemCodePageState();
}

class _ReedemCodePageState extends ConsumerState<ReedemCodePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                CustomBackButton(),
                SizedBox(
                  width: 10,
                ),
                CustomText2(
                  'Reedem Code',
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Hello World'),
          ],
        ),
      ),
    ));
  }
}
