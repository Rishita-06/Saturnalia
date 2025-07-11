import 'dart:async';

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../routing/router.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(appRepositoryProvider, (previous, next) async {
      if (next.status != previous?.status) {
        final router = context.router;

        switch (next.status) {
          case AppStatus.initial:
            router.replace(const AuthRoute());
            break;
          case AppStatus.maintainance:
          case AppStatus.updateApp:
            await Future.delayed(const Duration(milliseconds: 1500));

            router.replace(const UpdateAppRoute());
            break;

          case AppStatus.createAccount:
            await Future.delayed(const Duration(milliseconds: 1500));

            router.replace(CreateAccountRoute());
            break;
          case AppStatus.unauthenticated:
            await Future.delayed(const Duration(milliseconds: 1500));
            router.replace(const AuthRoute());
            break;
          case AppStatus.noSponserAppsInstalled:
            // navigate to main after a delay
            await Future.delayed(const Duration(milliseconds: 1500));
            router.replace(const SponsersRoute());
            break;
          case AppStatus.authenticated:
            // navigate to create profile after a delay
            await Future.delayed(const Duration(milliseconds: 1500));
            router.replace(const MainRoute());
            break;
        }
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/login.png',
                fit: BoxFit.cover,
                width: MediaQuery.sizeOf(context).width,
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/sat_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                bottom: 70,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
