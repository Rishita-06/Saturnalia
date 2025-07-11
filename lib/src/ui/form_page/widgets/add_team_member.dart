// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/models/user_data.dart';
import 'package:Saturnalia/src/ui/form_page/form_page_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import '../../../constants/colors.dart';

import '../../../models/team_data.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/toast_utils.dart';
import '../../store/widgets/team_data_card.dart';
import '../../widgets/custom_text.dart';

showAddTeamMemberBottomSheet(BuildContext context, int id) {
  return showSaturnaliaBottomSheet(
    isDismissible: false,
    context: context,
    builder: (context) => AddMemberPage(
      id: id,
    ),
  );
}

class AddMemberPage extends ConsumerStatefulWidget {
  final int id;
  const AddMemberPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends ConsumerState<AddMemberPage> {
  UserData? data;
  String email = '';
  int? newRoleId;
  bool isProcessing = false;
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  CustomText2(
                    'Search Member',
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (data == null) ...[
                CustomTextField(
                  backgroundColor: const Color.fromARGB(255, 46, 45, 45),
                  hintText: 'Enter user unique event Id',
                  label: "Search using user unique event Id",
                  hint: 'Available on event page of the user',
                  onChanged: (value) {
                    email = value;
                  },
                  initialText: email,
                  maxLength: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {},
                      child: GestureDetector(
                        onTap: () async {
                          if (!isSearching) {
                            setState(() {
                              isSearching = true;
                            });

                            final res = await ref
                                .read(formPageProvider.notifier)
                                .searchMember(email);
                            if (res.keys.first != null) {
                              setState(() {
                                data = res.keys.first;
                              });
                              setState(() {
                                isSearching = false;
                              });
                            } else {
                              showErrorMessage(context, res.values.first);
                              setState(() {
                                isSearching = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: isSearching
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                      ),
                                    )
                                  : Text(
                                      'Search',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
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
              if (data != null) ...[
                Stack(
                  children: [
                    TeamDataCard(
                        data: TeamData(
                      coins: data!.coins,
                      userId: data!.userId,
                      userName: data!.userName,
                      phoneNumber: data!.phoneNumber,
                      graduationYear: data!.graduationYear,
                      email: data!.email,
                      roleId: 2,
                      gender: data!.gender,
                    )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (!isProcessing) {
                            setState(() {
                              data = null;
                              email = '';
                            });
                          }
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        if (!isProcessing) {
                          setState(() {
                            isProcessing = true;
                          });

                          final res = ref
                              .read(formPageProvider.notifier)
                              .setTeamMember(widget.id, data!);
                          if (res != '') {
                            showErrorMessage(context, res);
                            setState(() {
                              isProcessing = false;
                            });
                          } else {
                            context.maybePop();
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: newRoleId != 2
                              ? primaryColor
                              : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: isProcessing
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                    ),
                                  )
                                : Text(
                                    'Add Member',
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 15,
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
                  height: 40,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
