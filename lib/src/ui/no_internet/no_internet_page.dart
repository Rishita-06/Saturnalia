import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import '../../utils/network_utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_scaffold.dart';

@RoutePage()
class NoInternetPage extends ConsumerStatefulWidget {
  final Function(bool hasInternet) onChanged;
  final bool isAuth;
  const NoInternetPage({
    Key? key,
    required this.onChanged,
    this.isAuth = true,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends ConsumerState<NoInternetPage> {
  bool isProcessing = false;

  retry() async {
    setState(() => isProcessing = true);

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (await hasInternetAccess()) {
          widget.onChanged(true);
        } else {
          widget.onChanged(false);
        }
        setState(() => isProcessing = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: CustomScaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  child: Lottie.asset(
                    'assets/lottie/ic_no_internet.json',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'No Internet!',
                  style: GoogleFonts.rocknRollOne(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Check your Internet Connection...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 200,
                      onTap: retry,
                      text: 'Try Again',
                      isProcessing: isProcessing,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
