// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/ui/create/widgets/custom_drop_down.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';

import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import 'package:Saturnalia/src/ui/create/widgets/gender_section.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../constants/colors.dart';
import '../../routing/router.dart';
import '../../utils/toast_utils.dart';
import '../../utils/web_utils.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/try_again_widget.dart';
import 'create_account_page_model.dart';

@RoutePage()
class CreateAccountPage extends ConsumerStatefulWidget {
  final bool isEditing;
  const CreateAccountPage({
    super.key,
    this.isEditing = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(
      appRepositoryProvider.select((_) => _.authUser),
    );

    ref.listen(appRepositoryProvider, (previous, next) {
      if (next.status != previous?.status) {
        if (next.status == AppStatus.authenticated) {
          showSuccessMessage(context, 'User Signed In Succesfully');
          context.replaceRoute(const MainRoute());
        } else if (next.status == AppStatus.unauthenticated) {
          context.replaceRoute(const AuthRoute());
        }
      }
    });
    final selectedId = ref.watch(
      createAccountPageProvider.select((_) => _.graduationYear),
    );
    final status = ref.watch(
      createAccountPageProvider.select((_) => _.status),
    );

    final isEligible = ref.watch(
      createAccountPageProvider.select(
        (_) => _.eligible,
      ),
    );
    final isThaparId = ref.watch(
      appRepositoryProvider.select((_) => _.thaparId),
    );
    final name =
        ref.read(createAccountPageProvider.select((value) => value.name));
    final email =
        ref.read(createAccountPageProvider.select((value) => value.email));
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoOverscrollScrollBehavior(),
        child: CustomScaffold(
          body: status == CreatePageStatus.loaded
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              if (widget.isEditing) ...[
                                const CustomBackButton(),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                              CustomText2(
                                color: Colors.white,
                                !widget.isEditing
                                    ? isEligible
                                        ? 'Sign Up'
                                        : 'Sign Up'
                                    : "Edit Details",
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (!widget.isEditing) ...[
                          Text(
                            'Just one last step 🙃😁😊',
                            style: GoogleFonts.rocknRollOne(
                              fontSize: 22,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                        CustomTextField(
                          hintText: 'Name',
                          label: 'Name',
                          isEnabled: widget.isEditing
                              ? false
                              : Platform.isIOS
                                  ? userData?.displayName != null
                                      ? false
                                      : true
                                  : false,
                          onChanged: (value) {
                            ref
                                .read(createAccountPageProvider.notifier)
                                .setName(value);
                          },
                          initialText: userData?.displayName ??
                              (Platform.isIOS ? name : ''),
                          maxLength: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Enter email-id',
                          label: 'Email Id',
                          isEnabled: widget.isEditing
                              ? false
                              : Platform.isIOS
                                  ? userData?.email != null
                                      ? false
                                      : true
                                  : false,
                          onChanged: (value) {
                            ref
                                .read(createAccountPageProvider.notifier)
                                .setEmail(value);
                          },
                          initialText:
                              userData?.email ?? (Platform.isIOS ? email : ''),
                          maxLength: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Enter Phone Number',
                          label: 'Phone Number',
                          onChanged: (value) {
                            ref
                                .read(createAccountPageProvider.notifier)
                                .setPhone(int.parse(value == '' ? '0' : value));
                          },
                          initialText: ref
                                  .read(createAccountPageProvider
                                      .select((_) => _.mobile))
                                  ?.toString() ??
                              '',
                          isDigitOnly: true,
                          maxLength: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const GenderSection(),
                        if (userData?.email != null &&
                            userData?.email?.split('@')[1] == 'thapar.edu') ...[
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Enter roll number',
                            label: 'Roll Number',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setRollNumber(
                                      int.parse(value == '' ? '0' : value));
                            },
                            isDigitOnly: true,
                            initialText: ref
                                    .read(createAccountPageProvider
                                        .select((_) => _.rollNumber))
                                    ?.toString() ??
                                '',
                            maxLength: 9,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'COPC,COE,ECE,EIC,EEC,etc...',
                            label: 'Branch',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setBranch(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.branch)),
                            maxLength: 10,
                          ),
                        ] else ...[
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Enter college name',
                            label: 'College Name',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setCollegeName(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.collegeName)),
                            maxLength: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Enter college city',
                            label: 'College City',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setCollegeCity(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.collegeCity)),
                            maxLength: 30,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Enter college state',
                            label: 'College State',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setCollegeState(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.collegeState)),
                            maxLength: 30,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Enter college city pin code',
                            label: 'Pin Code',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setCollegePinCode(
                                      int.parse(value == '' ? '0' : value));
                            },
                            initialText: ref
                                    .read(createAccountPageProvider
                                        .select((_) => _.collegePinCode))
                                    ?.toString() ??
                                '',
                            isDigitOnly: true,
                            maxLength: 6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Computer Science,Electrical,etc...',
                            label: 'Stream (Branch)',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setBranch(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.branch)),
                            maxLength: 30,
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        CustomDropDownButton<String>(
                          label: 'Graduation Year',
                          selectedId: selectedId,
                          initialText: 'Year',
                          onChanged: (value) {
                            ref
                                .read(createAccountPageProvider.notifier)
                                .setGraduationYear(value);
                          },
                          data: const [
                            '2021',
                            '2022',
                            '2023',
                            '2024',
                            '2025',
                            '2026',
                            '2027',
                            '2028',
                            '2029',
                          ],
                        ),
                        if ((isEligible || !widget.isEditing) &&
                            isThaparId) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Have a Referral Code',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    '+5 coins will be rewarded for successful referral',
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            hintText: 'JHW78S',
                            label: '',
                            onChanged: (value) {
                              ref
                                  .read(createAccountPageProvider.notifier)
                                  .setReferralCode(value);
                            },
                            initialText: ref.read(createAccountPageProvider
                                .select((_) => _.referalCode)),
                            maxLength: 6,
                          ),
                        ],
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (isProcessing) {
                                    return;
                                  }
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  final res = await ref
                                      .read(createAccountPageProvider.notifier)
                                      .createAccount();
                                  if (res != '') {
                                    showErrorMessage(context, res);
                                    if (mounted) {
                                      setState(() {
                                        isProcessing = false;
                                      });
                                    }
                                  } else {
                                    if (mounted) {
                                      if (widget.isEditing) {
                                        showSuccessMessage(context,
                                            "Details updated successfully!");
                                        context.maybePop();
                                      }
                                      setState(() {
                                        isProcessing = false;
                                      });
                                    }
                                  }
                                },
                                text: isEligible && !widget.isEditing
                                    ? 'CONTINUE'
                                    : 'Update Account'.toUpperCase(),
                                isProcessing: isProcessing),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!widget.isEditing) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Go Back to Login Page',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ref
                                      .read(appRepositoryProvider.notifier)
                                      .logout(isFromCreatePage: true);
                                },
                                child: Text(
                                  'Click Here',
                                  style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.outfit(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'By logging in you agree that you accept our ',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        openUrl(
                                            'https://privacy-saturnalia.netlify.app');
                                      },
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '.',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                )
              : TryAgainWidget(
                  onTap: () {
                    ref.read(createAccountPageProvider.notifier).init();
                  },
                  noInternet: status == CreatePageStatus.error,
                  isProcessing: status == CreatePageStatus.loading ||
                      status == CreatePageStatus.initial,
                ),
        ),
      ),
    );
  }
}
