// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:Saturnalia/src/ui/manage_events/view_responses_page/view_responses_model.dart';
import 'package:Saturnalia/src/ui/widgets/delete_confirmation_popup.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../logic/repositories/app_repository/app_repository.dart';
import '../../../../models/event_user_data.dart';
import '../../../../utils/project_utils.dart';

class ResponseCard extends ConsumerStatefulWidget {
  final EventUserData data;
  final bool isEditing;
  final int teamMember;
  const ResponseCard({
    super.key,
    this.teamMember = 0,
    this.isEditing = true,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponseCardState();
}

class _ResponseCardState extends ConsumerState<ResponseCard> {
  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
            appRepositoryProvider.select((value) => value.userData?.isAdmin)) ??
        false;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor.withOpacity(0.5),
                      child: FutureBuilder<File>(
                        future:
                            getAvatarFile(widget.data.userId, widget.data.name),
                        initialData: null,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return SvgPicture.file(snapshot.data!);
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  Text(
                    widget.teamMember == 0 ? 'Team Size' : "Member",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.teamMember == 0
                        ? '${(widget.data.teamDetails?.length ?? 0) + 1}'
                        : widget.teamMember.toString(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.name,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.data.userEmail,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Mobile: ${widget.data.mobile}',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'College: ${widget.data.collegeAddress}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.isEditing)
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                if (widget.data.paymentStatus) {
                  return;
                }

                if (!roles) {
                  showErrorMessage(context,
                      'You don;t have access to update payment status');
                  return;
                }

                showDeleteConfirmationPopup(context,
                    title: 'Are you sure you want to confirm payment ?',
                    onCancel: () {
                      context.maybePop();
                    },
                    isProcessing: false,
                    onConfirm: () async {
                      final res = await ref
                          .read(viewResponsesPageProvider.notifier)
                          .updatePaymentStatus(widget.data);
                      if (res != '') {
                        showErrorMessage(context, res);
                      } else {
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.data?.name == 'ViewFormResponsesRoute');
                      }
                    });
              },
              child: Container(
                height: 25,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.data.paymentStatus
                      ? Colors.limeAccent[400]
                      : Colors.red,
                ),
                child: Center(
                  child: Text(
                    widget.data.paymentStatus ? 'Accepted' : 'Pending',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
