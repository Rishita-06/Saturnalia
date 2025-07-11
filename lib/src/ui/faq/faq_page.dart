import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';

import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../logic/services/firebase_firestore.dart';
import '../../utils/network_utils.dart';
import '../widgets/try_again_widget.dart';
import 'widgets/faq_card.dart';

@RoutePage()
class FaqPage extends ConsumerStatefulWidget {
  const FaqPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FaqPageState();
}

class _FaqPageState extends ConsumerState<FaqPage> {
  int? expandedId;
  bool isProcessing = true;
  String errorMessage = '';
  List<Map<String, String>> data = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getItemList();
    });
  }

  getItemList() async {
    if (mounted) {
      setState(() {
        errorMessage = '';
        isProcessing = true;
      });
      if (!await hasInternetAccess()) {
        setState(() {
          isProcessing = false;
          errorMessage = '2';
        });
        return;
      }

      await Future.delayed(const Duration(seconds: 1));

      final res =
          await ref.read(firebaseFirestoreProvider).collection('faqs').get();
      if (res.docs.isEmpty) {
        setState(() {
          errorMessage = 'Something Went Wrong';
          isProcessing = false;
        });
      } else {
        try {
          data = res.docs
              .map((e) =>
                  {e.data()['ques'] as String: e.data()['answer'] as String})
              .toList();
        } catch (e) {
          setState(() {
            errorMessage = 'Something Went Wrong';
            isProcessing = false;
          });
        }
        if (mounted) {
          setState(() {
            errorMessage = '';
            isProcessing = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isProcessing
              ? TryAgainWidget(
                  onTap: () {},
                  isProcessing: isProcessing,
                )
              : errorMessage != ''
                  ? TryAgainWidget(
                      onTap: () async {
                        await getItemList();
                      },
                      noInternet: errorMessage == '2',
                      isProcessing: isProcessing,
                    )
                  : Column(
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
                              'FAQs',
                              size: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: NoOverscrollScrollBehavior(),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 40),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  if (expandedId == index) {
                                    setState(() {
                                      expandedId = null;
                                    });
                                  } else {
                                    setState(() {
                                      expandedId = index;
                                    });
                                  }
                                },
                                child: FaqCard(
                                  isExpanded: expandedId == index,
                                  isVisible: true,
                                  ques: data[index].keys.first,
                                  answer: data[index].values.first,
                                ),
                              ),
                              itemCount: data.length,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
