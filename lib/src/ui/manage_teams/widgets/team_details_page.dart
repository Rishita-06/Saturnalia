import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/models/team_data.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../utils/project_utils.dart';
import '../../widgets/delete_confirmation_popup.dart';
import '../manage_team_page_model.dart';
import '../../store/widgets/team_data_card.dart';

class TeamsDetailsPage extends ConsumerStatefulWidget {
  final List<TeamData> data;
  final bool isRemovable;
  const TeamsDetailsPage({
    super.key,
    required this.data,
    required this.isRemovable,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TeamsDetailsPageState();
}

class _TeamsDetailsPageState extends ConsumerState<TeamsDetailsPage> {
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.isAdmin ?? false),
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.data
            .map((e) => Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _showMemberDetails(context, e);
                        },
                        child: TeamDataCard(
                          data: e,
                        ),
                      ),
                    ),
                    if (widget.isRemovable && roles)
                      Positioned(
                        right: 18,
                        bottom: 13,
                        child: GestureDetector(
                          onTap: () {
                            showDeleteConfirmationPopup(
                              context,
                              title:
                                  'Are you sure you want to remove this user ?',
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
                                    .read(manageTeamPageProvider.notifier)
                                    .updateRoleId(2, e.userId);
                                if (res != '') {
                                  showErrorMessage(context, res);
                                  setState(() {
                                    isDeleting = false;
                                  });
                                } else {
                                  showSuccessMessage(context, 'User removed!');
                                  context.maybePop();
                                }
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
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
                ))
            .toList(),
      ),
    );
  }
}

_showMemberDetails(BuildContext context, TeamData data) {
  return showSaturnaliaBottomSheet(
      context: context,
      builder: (context) => _MemberDetails(
            data: data,
          ));
}

class _MemberDetails extends ConsumerStatefulWidget {
  final TeamData data;
  const _MemberDetails({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __MemberDetailsState();
}

class __MemberDetailsState extends ConsumerState<_MemberDetails> {
  int? newRoleId;
  bool isProcessing = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      newRoleId = widget.data.roleId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.data.userName,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FittedBox(
                    child: Text(
                      'Email: ${widget.data.email}',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    'Phone : ${widget.data.phoneNumber}',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Graduation Year : ${widget.data.graduationYear}',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Role:',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //     if (roleId < widget.data.roleId &&
                      //         teams.keys
                      //                 .where((element) => element > roleId)
                      //                 .length >=
                      //             2 &&
                      //         (roleId != 1)) ...[
                      //       CustomSatDropDownButton<int>(
                      //         selectedId: newRoleId,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             newRoleId = value;
                      //           });
                      //         },
                      //         data: teams.keys
                      //             .where((element) => element > roleId)
                      //             .map((e) => {e: teams[e] ?? ''})
                      //             .toList(),
                      //       ),
                      //     ] else
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           color: Colors.white.withOpacity(0.3),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10, vertical: 2),
                      //           child: Text(
                      //             team[widget.data.roleId] ?? 'Team',
                      //             style: GoogleFonts.outfit(
                      //               color: Colors.white,
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // if (roleId < widget.data.roleId &&
                  //     teams.keys.where((element) => element > roleId).length >=
                  //         2 &&
                  //     (roleId != 1))
                  //   Row(
                  //     children: [
                  //       GestureDetector(
                  //         behavior: HitTestBehavior.opaque,
                  //         onTap: () async {
                  //           if (newRoleId != widget.data.roleId &&
                  //               !isProcessing) {
                  //             setState(() {
                  //               isProcessing = true;
                  //             });
                  //             final res = await ref
                  //                 .read(manageTeamPageProvider.notifier)
                  //                 .updateRoleId(newRoleId!, widget.data.userId);
                  //             if (res != '') {
                  //               showErrorMessage(context, res);
                  //               setState(() {
                  //                 isProcessing = false;
                  //               });
                  //             } else {
                  //               showSuccessMessage(
                  //                   context, 'Role updated successfully!');
                  //               Navigator.pop(context);
                  //             }
                  //           }
                  //         },
                  //         child: Container(
                  //           height: 40,
                  //           decoration: BoxDecoration(
                  //             color: newRoleId != widget.data.roleId
                  //                 ? primaryColor
                  //                 : Colors.white.withOpacity(0.3),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Padding(
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 20),
                  //             child: Center(
                  //               child: isProcessing
                  //                   ? const SizedBox(
                  //                       height: 20,
                  //                       width: 20,
                  //                       child: CircularProgressIndicator(
                  //                         strokeWidth: 1.5,
                  //                       ),
                  //                     )
                  //                   : Text(
                  //                       'Update Role',
                  //                       style: GoogleFonts.outfit(
                  //                         color: Colors.white,
                  //                         fontSize: 15,
                  //                         fontWeight: FontWeight.w400,
                  //                       ),
                  //                     ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 1.5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor.withOpacity(0.5),
                  child: FutureBuilder<File>(
                    future:
                        getAvatarFile(widget.data.userId, widget.data.userName),
                    initialData: null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return SvgPicture.file(snapshot.data!);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
