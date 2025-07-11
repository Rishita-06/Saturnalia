import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';

import '../../constants/colors.dart';

showDeleteConfirmationPopup(
  BuildContext context, {
  required String title,
  required VoidCallback onCancel,
  required bool isProcessing,
  required Future Function() onConfirm,
}) {
  return showSaturnaliaBottomSheet(
    context: context,
    builder: (context) => ShowDeleteConfirmation(
      key: ValueKey(isProcessing),
      onCancel: onCancel,
      onConfirm: onConfirm,
      title: title,
    ),
  );
}

class ShowDeleteConfirmation extends ConsumerStatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final Future Function() onConfirm;

  const ShowDeleteConfirmation({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    required this.title,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowDeleteConfirmationState();
}

class _ShowDeleteConfirmationState
    extends ConsumerState<ShowDeleteConfirmation> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: isProcessing ? null : widget.onCancel,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Center(
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: isProcessing
                        ? null
                        : () async {
                            setState(() {
                              isProcessing = true;
                            });
                            await Future.delayed(Duration.zero, () async {
                              await widget.onConfirm();
                            });
                            setState(() {
                              isProcessing = false;
                            });
                          },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: isProcessing
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.8,
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'Yes',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
