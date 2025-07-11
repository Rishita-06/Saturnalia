// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:Saturnalia/src/models/corousal_data.dart';
import 'package:Saturnalia/src/ui/corousal/edit_corousal_page_model.dart';
import 'package:Saturnalia/src/ui/corousal/widgets/corousal_type.dart';
import 'package:Saturnalia/src/ui/widgets/corousal_widget.dart';

import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';

import '../../../utils/toast_utils.dart';
import '../../widgets/custom_sat_drop_down.dart';

showAddNewCorousal(BuildContext context, WidgetRef ref, CorousalData? data) {
  return showSaturnaliaBottomSheet(
      context: context,
      builder: (context) => _AddCorousalBottomSheet(data: data))
    ..whenComplete(() => ref.read(corousalPageProvider.notifier).clearData());
}

class _AddCorousalBottomSheet extends ConsumerStatefulWidget {
  final CorousalData? data;
  const _AddCorousalBottomSheet({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AddCorousalBottomSheetState();
}

class __AddCorousalBottomSheetState
    extends ConsumerState<_AddCorousalBottomSheet> {
  bool isProcessing = false;
  bool isProcessing2 = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(corousalPageProvider.notifier).addCorousalData(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bannerUrl = ref.watch(
      corousalPageProvider.select((_) => _.bannerImageUrl),
    );
    ref.listen(corousalPageProvider, (prev, next) {
      if (prev?.bannerImageUrl != next.bannerImageUrl) {
        if (next.bannerImageUrl.trim().isNotEmpty) {
          setState(() {
            isProcessing = false;
          });
        }
      }
    });
    final type = ref.watch(
      corousalPageProvider.select(
        (_) => _.corousalType,
      ),
    );
    final eventId = ref.watch(
      corousalPageProvider.select(
        (_) => _.eventId,
      ),
    );
    final events = ref.watch(
      eventsPageProvider.select((_) => _.allPublicEvents),
    );
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.data != null
                      ? 'Edit Corousal Details'
                      : 'Add Corousal Image',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (bannerUrl.trim().isNotEmpty) ...[
                  Stack(
                    children: [
                      CorousalWidget(imageUrl: bannerUrl),
                      if (widget.data == null)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              if (!isProcessing || !isProcessing2) {
                                ref
                                    .read(corousalPageProvider.notifier)
                                    .setBannerUrl('');
                              }
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      if (!(isProcessing || isProcessing2)) {
                        setState(() {
                          isProcessing = true;
                        });
                        final res = await ref
                            .read(corousalPageProvider.notifier)
                            .pickFile();
                        if (res != '') {
                          showErrorMessage(context, res);
                          setState(() {
                            isProcessing = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryContainerColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 190,
                      child: isProcessing
                          ? Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white.withOpacity(0.6),
                                size: 40,
                              ),
                            ),
                    ),
                  )
                ],
                const SizedBox(
                  height: 10,
                ),
                const CorousalTypeSection(),
                const SizedBox(
                  height: 10,
                ),
                if (type == 0) ...[
                  CustomTextField(
                    backgroundColor: secondaryColor,
                    hintText: 'Add Link',
                    label: '',
                    onChanged: (value) {
                      ref.read(corousalPageProvider.notifier).setLink(value);
                    },
                    initialText: ref
                        .read(corousalPageProvider.select((_) => _.link ?? '')),
                    maxLength: null,
                  ),
                ] else if (type == 1) ...[
                  CustomSatDropDownButton<String>(
                    selectedId: eventId,
                    backgroundColor: secondaryContainerColor,
                    width: 250,
                    initialText: 'Select Event',
                    onChanged: (value) {
                      ref.read(corousalPageProvider.notifier).setEventId(value);
                    },
                    data: events!
                        .map((e) => {e.details.eventId: e.details.title})
                        .toList(),
                  ),
                ],
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () async {
                    if (!(isProcessing || isProcessing2)) {
                      setState(() {
                        isProcessing2 = true;
                      });

                      final res = widget.data != null
                          ? await ref
                              .read(corousalPageProvider.notifier)
                              .editCorousal()
                          : await ref
                              .read(corousalPageProvider.notifier)
                              .addCorousal();
                      if (res != '') {
                        showErrorMessage(context, res);
                        setState(() {
                          isProcessing2 = false;
                        });
                      } else {
                        showSuccessMessage(
                            context,
                            widget.data != null
                                ? "Corousal edited succesfully"
                                : "Corousal added successfully!");
                        setState(() {
                          isProcessing2 = false;
                        });
                        Navigator.pop(context);
                      }
                    }
                  },
                  text: 'Add Corousal',
                  isProcessing: isProcessing2,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
