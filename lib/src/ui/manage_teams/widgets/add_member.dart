// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../models/team_data.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/toast_utils.dart';
import '../../store/widgets/team_data_card.dart';
import '../../widgets/custom_text.dart';
import '../manage_team_page_model.dart';
import '../../widgets/custom_sat_drop_down.dart';

showAddMemberBottomSheet(BuildContext context) {
  return showSaturnaliaBottomSheet(
    isDismissible: false,
    context: context,
    builder: (context) => const AddMemberPage(),
  );
}

class AddMemberPage extends ConsumerStatefulWidget {
  const AddMemberPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends ConsumerState<AddMemberPage> {
  TeamData? data;
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
    final roles = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.isAdmin ?? false),
    );
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
                  hintText: 'Enter mail',
                  label: "Search",
                  onChanged: (value) {
                    email = value;
                  },
                  initialText: email,
                  maxLength: null,
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
                                .read(manageTeamPageProvider.notifier)
                                .searchMember(email);
                            if (res != null) {
                              setState(() {
                                data = res;
                              });
                              setState(() {
                                isSearching = false;
                              });
                            } else {
                              showErrorMessage(
                                  context, "No user found with this email");
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
                    TeamDataCard(data: data!),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            data = null;
                            email = '';
                          });
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
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Role:',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (data!.roleId == 2) ...[
                      CustomSatDropDownButton<int>(
                        selectedId: newRoleId,
                        initialText: 'Select Role',
                        onChanged: (value) {
                          setState(() {
                            newRoleId = value;
                          });
                        },
                        data: [adminTeams],
                      ),
                    ] else
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Text(
                            team[data!.roleId] ?? 'Team',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (data!.roleId == 2)
                  Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          if (newRoleId != data!.roleId && !isProcessing) {
                            setState(() {
                              isProcessing = true;
                            });
                            final res = await ref
                                .read(manageTeamPageProvider.notifier)
                                .updateRoleId(newRoleId!, data!.userId);
                            if (res != '') {
                              showErrorMessage(context, res);
                              setState(() {
                                isProcessing = false;
                              });
                            } else {
                              showSuccessMessage(
                                  context, 'Role updated successfully!');
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: newRoleId != data!.roleId
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
