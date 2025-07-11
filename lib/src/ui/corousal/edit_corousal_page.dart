import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/corousal/widgets/add_corousal.dart';
import 'package:Saturnalia/src/ui/widgets/corousal_widget.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/ui/widgets/delete_confirmation_popup.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';

import 'edit_corousal_page_model.dart';

@RoutePage()
class EditCorousalPage extends ConsumerStatefulWidget {
  const EditCorousalPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCorousalPageState();
}

class _EditCorousalPageState extends ConsumerState<EditCorousalPage> {
  bool isDeleting = false;
  bool isUpdating = false;
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      corousalPageProvider.select((_) => _.status),
    );
    final lists = ref.watch(
      corousalPageProvider.select((_) => _.data),
    );

    return SafeArea(
      child: CustomScaffold(
        body: status == CorousalPageStatus.loaded
            ? Padding(
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
                          'Edit Corousal',
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: NoOverscrollScrollBehavior(),
                        child: (lists != null && lists.isEmpty)
                            ? Center(
                                child: Text(
                                  'No corousal found',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: lists?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Stack(
                                  children: [
                                    CorousalWidget(
                                      imageUrl: lists![index].imageUrl,
                                    ),
                                    Positioned(
                                      right: 15,
                                      bottom: 35,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAddNewCorousal(
                                              context, ref, lists[index]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 15,
                                      bottom: 105,
                                      child: Tooltip(
                                        message:
                                            'Toogle to make it public or private',
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 0),
                                              child: SizedBox(
                                                height: 30,
                                                width: 40,
                                                child: FittedBox(
                                                  child: CupertinoSwitch(
                                                      value: lists[index]
                                                              .isPublic ??
                                                          false,
                                                      onChanged: (value) async {
                                                        if (!isUpdating) {
                                                          setState(() {
                                                            isUpdating = true;
                                                          });
                                                          final res = await ref
                                                              .read(
                                                                  corousalPageProvider
                                                                      .notifier)
                                                              .updateCorousalVisibility(
                                                                  value,
                                                                  lists[index]
                                                                      .id);
                                                          if (res != '') {
                                                            showErrorMessage(
                                                                context, res);
                                                          }
                                                          setState(() {
                                                            isUpdating = false;
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 15,
                                      bottom: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDeleteConfirmationPopup(
                                            context,
                                            title:
                                                'Are you sure you want to delete this corousal ?',
                                            onCancel: () {
                                              context.maybePop();
                                            },
                                            isProcessing: isDeleting,
                                            onConfirm: () async {
                                              setState(() {
                                                isDeleting = true;
                                              });
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              final res = await ref
                                                  .read(corousalPageProvider
                                                      .notifier)
                                                  .deleteCorousal(
                                                      lists[index].id);
                                              if (res != '') {
                                                showErrorMessage(context, res);
                                                setState(() {
                                                  isDeleting = false;
                                                });
                                              } else {
                                                showSuccessMessage(context,
                                                    'Corousal deleted!');
                                                context.maybePop();
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            child: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              )
            : TryAgainWidget(
                onTap: () {
                  ref.read(corousalPageProvider.notifier).init();
                },
                isProcessing: status == CorousalPageStatus.loading ||
                    status == CorousalPageStatus.initial),
        floatingActionButton: status == CorousalPageStatus.loaded
            ? FloatingActionButton(
                onPressed: () {
                  showAddNewCorousal(context, ref, null);
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
