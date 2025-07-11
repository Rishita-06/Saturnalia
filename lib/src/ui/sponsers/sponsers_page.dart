// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../routing/router.dart';
import '../../utils/toast_utils.dart';

@RoutePage()
class SponsersPage extends ConsumerStatefulWidget {
  const SponsersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SponsersPage> createState() => _SponsersPageState();
}

class _SponsersPageState extends ConsumerState<SponsersPage> {
  List<AppInfo> installedApps = [];

  @override
  void initState() {
    getApps(ref: ref);
    super.initState();
  }

  Future<void> showToastss() async {
    showSuccessMessage(context, "Checking Again!");
  }

  Future<void> getApps({required WidgetRef ref}) async {
    installedApps.clear();
    setState(() {});

    await Future.delayed(const Duration(seconds: 1));

    final sponserApp =
        ref.read(appRepositoryProvider.select((_) => _.sponserApp));
    if (sponserApp == null) {
      context.replaceRoute(const HomeRoute());
      return;
    }
    if (sponserApp.isEmpty) {
      context.replaceRoute(const HomeRoute());
      return;
    }

    for (var e in sponserApp) {
      // await AppCheck.checkAvailability(
      //         Platform.isAndroid ? e.androidPackageName : e.iosPackageName)
      //     .then(
      //   (app) {
      //     if (app != null) {
      //       // debugPrint(app.toString());
      //     }
      //   },
      // ).onError((error, stackTrace) {
      //   installedApps.add(
      //     AppInfo(
      //         packageName:
      //             Platform.isAndroid ? e.androidPackageName : e.iosPackageName,
      //         appName: e.appName),
      //   );
      // });
    }
    setState(() {});
    if (installedApps.isEmpty) {
      context.replaceRoute(const HomeRoute());
      showSuccessMessage(context, 'All Apps Installed!');
      return;
    } else {
      showErrorMessage(context, 'Some Apps Are Not Installed Yet');
    }

    installedApps.sort(
      (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sponsers\'s App'),
        ),
        body: installedApps.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: installedApps.length,
                itemBuilder: (context, index) {
                  final app = installedApps[index];

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/google_logo.png',
                        height: 40,
                      ),
                    ),
                    title: Text(
                      app.appName ?? app.packageName,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      (app.isSystemApp ?? false) ? 'System App' : 'User App',
                    ),
                    trailing: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            'Install',
                            style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showToastss();
                    getApps(ref: ref);
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
