// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';

import 'package:Saturnalia/src/models/form_data.dart';
import 'package:Saturnalia/src/ui/manage_events/view_responses_page/view_responses_model.dart';
import 'package:Saturnalia/src/ui/manage_events/view_responses_page/widgets/show_team_details_page.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/back_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_text.dart';
import 'widgets/response_card.dart';

@RoutePage()
class ViewFormResponsesPage extends ConsumerStatefulWidget {
  final String eventId;
  final String eventName;
  final FormData? data;
  final bool hasForm;

  const ViewFormResponsesPage({
    super.key,
    required this.eventId,
    required this.eventName,
    required this.hasForm,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends ConsumerState<ViewFormResponsesPage> {
  bool isProcessing = false;
  bool isProcessing2 = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref
          .read(viewResponsesPageProvider.notifier)
          .init(widget.eventId, widget.eventName, widget.hasForm, widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final status =
        ref.watch(viewResponsesPageProvider.select((value) => value.status));
    final responses =
        ref.watch(viewResponsesPageProvider.select((value) => value.data));
    final participants = responses
            ?.where(
              (element) => element.formResponse != null,
            )
            .toList() ??
        [];
    final roles = ref.watch(
            appRepositoryProvider.select((value) => value.userData?.isAdmin)) ??
        false;
    return SafeArea(
      child: CustomScaffold(
        body: status == ViewResponsesPageStatus.loaded
            ? ScrollConfiguration(
                behavior: NoOverscrollScrollBehavior(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            CustomBackButton(),
                            SizedBox(width: 10),
                            CustomText2(
                              'Responses',
                              size: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Total Responses :  ',
                            //       style: GoogleFonts.lato(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //     Text(
                            //       responses!.length.toString(),
                            //       style: GoogleFonts.lato(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w600,
                            //         color: primaryColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   width: 30,
                            // ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Participants : ',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  participants.length.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if (roles) ...[
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       right: 50, top: 50, left: 50, bottom: 20),
                              //   child: CustomButton(
                              //     onTap: () async {
                              //       if (!isProcessing && !isProcessing2) {
                              //         setState(() {
                              //           isProcessing = true;
                              //         });

                              //         final file = await ref
                              //             .read(viewResponsesPageProvider.notifier)
                              //             .saveCsvToFile();
                              //         if (file == null) {
                              //           showErrorMessage(context,
                              //               'Something went wrong while creating csv');
                              //           setState(() {
                              //             isProcessing = false;
                              //           });
                              //         } else {
                              //           Share.shareXFiles([file]);
                              //           setState(() {
                              //             isProcessing = false;
                              //           });
                              //         }
                              //       }
                              //     },
                              //     text: 'Share All Data',
                              //     isProcessing: isProcessing,
                              //   ),
                              // ),
                              // if (participants >= 5)

                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  top: 0,
                                  left: 10,
                                ),
                                child: CustomButton(
                                  width: 100,
                                  height: 35,
                                  onTap: () async {
                                    if (!isProcessing && !isProcessing2) {
                                      setState(() {
                                        isProcessing2 = true;
                                      });

                                      final file = await ref
                                          .read(viewResponsesPageProvider
                                              .notifier)
                                          .saveCsvToFile(
                                              onlyParticipants: true);
                                      if (file == null) {
                                        showErrorMessage(context,
                                            'Something went wrong while creating csv');
                                        setState(() {
                                          isProcessing2 = false;
                                        });
                                      } else {
                                        Share.shareXFiles([file]);
                                        setState(() {
                                          isProcessing2 = false;
                                        });
                                      }
                                    }
                                  },
                                  text: 'Share CSV',
                                  isProcessing: isProcessing,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: participants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    showTeamDetailsBottomSheet(
                                        context, (participants[index]));
                                  },
                                  child:
                                      ResponseCard(data: participants[index])),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : TryAgainWidget(
                onTap: () {
                  ref.read(viewResponsesPageProvider.notifier).init(
                      widget.eventId,
                      widget.eventName,
                      widget.hasForm,
                      widget.data);
                },
                noInternet: status == ViewResponsesPageStatus.noInternet,
                isProcessing: status == ViewResponsesPageStatus.loading ||
                    status == ViewResponsesPageStatus.initial,
              ),
      ),
    );
  }
}
