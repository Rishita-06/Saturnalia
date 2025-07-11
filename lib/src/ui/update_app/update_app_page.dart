import 'package:Saturnalia/src/constants/strings.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/utils/web_utils.dart';

@RoutePage()
class UpdateAppPage extends ConsumerStatefulWidget {
  const UpdateAppPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends ConsumerState<UpdateAppPage> {
  @override
  Widget build(BuildContext context) {
    final status =
        ref.watch(appRepositoryProvider.select((value) => value.status));
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              opacity: 0.5,
              image: AssetImage(
                'assets/images/login.png',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Text(
                  status == AppStatus.maintainance
                      ? 'App Under Maintenance\nPlease check back later\nThank you for your understanding'
                      : 'Update your application to the latest version',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rocknRollOne(
                    fontSize: status == AppStatus.maintainance ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                if (!(status == AppStatus.maintainance))
                  CustomButton(
                    onTap: () {
                      openUrl(storeUrl);
                    },
                    text: 'UPDATE NOW',
                    isProcessing: false,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
