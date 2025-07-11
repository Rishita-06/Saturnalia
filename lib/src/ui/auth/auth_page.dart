import 'dart:io';

import 'package:Saturnalia/src/utils/web_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../routing/router.dart';
import '../../utils/toast_utils.dart';
import 'auth_page_model.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appRepositoryProvider, (previous, next) {
      if (next.status != previous?.status) {
        if (next.status == AppStatus.authenticated) {
          showSuccessMessage(context, 'User Signed In Succesfully');
          context.replaceRoute(const MainRoute());
        } else if (next.status == AppStatus.noSponserAppsInstalled) {
          context.replaceRoute(const SponsersRoute());
        } else if (next.status == AppStatus.createAccount) {
          context.replaceRoute(CreateAccountRoute());
        }
      }
    });
    ref.listen(authPageModelProvider, (previous, next) {
      if (next.status == AuthPageStatus.error) {}
    });
    final status = ref.watch(
      authPageModelProvider.select((_) => _.status),
    );
    final appStatus = ref.watch(
      appRepositoryProvider.select((value) => value.status),
    );
    // debugPrint(status.toString());
    debugPrint(appStatus.toString());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/login.png',
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/sat_logo.png',
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (status == AuthPageStatus.authenticatingWithGoogle ||
                            status == AuthPageStatus.authenticatingWithApple ||
                            status == AuthPageStatus.authenticated) {
                          return;
                        }

                        final res = await ref
                            .read(authPageModelProvider.notifier)
                            .signin();
                        if (res == '') {
                        } else {
                          showErrorMessage(context, res);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: status ==
                                  AuthPageStatus.authenticatingWithGoogle
                              ? const Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google_logo.png',
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        "Sign in with Google",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  if (Platform.isIOS) ...[
                    const SizedBox(
                      height: 30,
                      child: Center(child: Text('or')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SignInWithAppleButton(
                        onPressed: () async {
                          if (status ==
                                  AuthPageStatus.authenticatingWithGoogle ||
                              status ==
                                  AuthPageStatus.authenticatingWithApple ||
                              status == AuthPageStatus.authenticated) {
                            return;
                          }
                          final res = await ref
                              .read(authPageModelProvider.notifier)
                              .signInWithApple();
                          if (res == '') {
                            // showSuccessMessage(
                            //     context, 'User Signed In Succesfully');
                          } else {
                            showErrorMessage(context, res);
                          }
                        },
                        style: SignInWithAppleButtonStyle.white,
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 30,
                    //   ),
                    //   child: InkWell(
                    //     onTap: () async {

                    //     },
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 10,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white.withOpacity(0.3),
                    //         borderRadius: BorderRadius.circular(15),
                    //         border: Border.all(
                    //           color: Colors.white,
                    //           width: 2,
                    //         ),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         child: status ==
                    //                 AuthPageStatus.authenticatingWithApple
                    //             ? const Center(
                    //                 child: SizedBox(
                    //                   height: 25,
                    //                   width: 25,
                    //                   child: CircularProgressIndicator(
                    //                     strokeWidth: 3,
                    //                     color: primaryColor,
                    //                   ),
                    //                 ),
                    //               )
                    //             : Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Image.asset(
                    //                     'assets/images/ic_apple.png',
                    //                     height: 25,
                    //                   ),
                    //                   Expanded(
                    //                     child: Center(
                    //                       child: Text(
                    //                         'Sign in with Apple ',
                    //                         overflow: TextOverflow.ellipsis,
                    //                         style: GoogleFonts.outfit(
                    //                           fontSize: 18,
                    //                           fontWeight: FontWeight.w500,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
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
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
