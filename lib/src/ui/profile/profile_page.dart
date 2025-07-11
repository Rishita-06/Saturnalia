import 'dart:io';

import 'package:Saturnalia/src/utils/dialog_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:Saturnalia/src/ui/widgets/profile_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:Saturnalia/src/utils/web_utils.dart';
import '../../constants/strings.dart';
import '../../logic/repositories/app_repository/app_repository.dart';

import '../../utils/project_utils.dart';
import '../widgets/custom_scaffold.dart';

import 'widgets/profile_container.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? imageFile;
  @override
  void initState() {
    super.initState();
  }

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final userData = ref.read(
      appRepositoryProvider.select((_) => _.userData),
    );
    final referralCode = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.referalCode),
    );
    final isThaparId = ref.watch(
      appRepositoryProvider.select((_) => _.thaparId),
    );
    return CustomScaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ScrollConfiguration(
          behavior: NoOverscrollScrollBehavior(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      'Profile',
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: userData!.gender == 1
                                    ? secondaryColor
                                    : userData.gender == 2
                                        ? primaryColor
                                        : Colors.blue,
                                width: 0.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: userData.gender == 1
                                  ? secondaryColor.withOpacity(0.5)
                                  : userData.gender == 2
                                      ? primaryColor.withOpacity(0.5)
                                      : Colors.blue.withOpacity(0.5),
                              child: FutureBuilder<File>(
                                future: getAvatarFile(
                                    userData.userId, userData.userName),
                                initialData: null,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return SvgPicture.file(snapshot.data!);
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showSaturnaliaBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ProfileDialog();
                                  },
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondaryContainerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.qr_code_2,
                                    size: 20,
                                    color: userData.gender == 1
                                        ? secondaryColor
                                        : primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (userData.userName.trim()),
                              maxLines: 2,
                              style: GoogleFonts.lato(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (isThaparId) ...[
                    GestureDetector(
                      onTap: () async {
                        final box = context.findRenderObject() as RenderBox?;
                        Share.shareXFiles(
                            [(await assetToXFile('assets/images/logo.png'))!],
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size,
                            text:
                                '$storeUrl\n\nDownload the *Saturnalia App* now.\n${isThaparId ? ' Use the referral given below to get *+10 reward coins.*\n\n*REFERRAL CODE* : *$referralCode*' : ''}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DottedBorder(
                          dashPattern: const [5, 6],
                          color: Colors.white.withOpacity(0.7),
                          radius: const Radius.circular(10),
                          borderType: BorderType.RRect,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: secondaryContainerColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'REFERRAL (Tap to Share)',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.4),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  referralCode ?? '',
                                  style: GoogleFonts.crimsonText(
                                    fontSize: 23,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: secondaryContainerColor,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.only(
                  //               topLeft: Radius.circular(15),
                  //               bottomLeft: Radius.circular(15),
                  //             ),
                  //             color: Colors.green,
                  //           ),
                  //           child: Center(
                  //             child: Text('Yes'),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.only(
                  //               topRight: Radius.circular(15),
                  //               bottomRight: Radius.circular(15),
                  //             ),
                  //             color: Colors.red,
                  //           ),
                  //           child: Text('No'),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   width: MediaQuery.sizeOf(context).width,
                  //   height: 45,
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  ProfilePageContainer(
                    label: 'Edit Details',
                    onTap: () {
                      context.navigateTo(CreateAccountRoute(isEditing: true));
                    },
                    icon: const Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Share App',
                    onTap: () async {
                      final box = context.findRenderObject() as RenderBox?;
                      Share.shareXFiles(
                          [(await assetToXFile('assets/images/logo.png'))!],
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                          text:
                              '$storeUrl\n\nDownload the *Saturnalia App* now.\n${isThaparId ? ' Use the referral given below to get *+10 reward coins.*\n\n*REFERRAL CODE* : *$referralCode*' : ''}');
                    },
                    icon: const Icon(
                      Icons.share,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Handbook',
                    onTap: () {
                      context.navigateTo(const TutorialRoute());
                    },
                    icon: const Icon(
                      Icons.list_alt_outlined,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Meet The Team',
                    onTap: () {
                      context.navigateTo(const MeetTheTeamRoute());
                    },
                    icon: const Icon(
                      CupertinoIcons.group_solid,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Follow Along',
                    onTap: () {
                      openUrl('https://www.instagram.com/saturnalia.thapar/');
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'FAQ',
                    onTap: () {
                      context.navigateTo(const FaqRoute());
                    },
                    icon: const Icon(
                      Icons.question_mark,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Contact Us',
                    onTap: () {
                      context.navigateTo(const ContactUsRoute());
                    },
                    icon: const Icon(
                      Icons.contact_support_rounded,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageContainer(
                    label: 'Privacy Policy',
                    onTap: () {
                      openUrl('https://privacy-saturnalia.netlify.app/');
                    },
                    icon: const Icon(
                      Icons.privacy_tip_rounded,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // ProfilePageContainer(
                  //   label: 'Request to Delete Account',
                  //   labelColor: Colors.red,
                  //   onTap: () {
                  //     openUrl('https://privacy-saturnalia.netlify.app/');
                  //   },
                  //   icon: const Icon(
                  //     Icons.delete,
                  //     color: Colors.red,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        width: 200,
                        isProcessing: isProcessing,
                        onTap: () async {
                          if (isProcessing) {
                            return;
                          }
                          setState(() {
                            isProcessing = true;
                          });
                          final res = await ref
                              .read(appRepositoryProvider.notifier)
                              .logout();
                          if (res != '') {
                            showErrorMessage(context, res);
                            setState(() {
                              isProcessing = false;
                            });
                            return;
                          } else {
                            showSuccessMessage(context, 'Logged out!');
                            setState(() {
                              isProcessing = false;
                            });
                          }
                        },
                        text: 'Log Out'.toUpperCase(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
