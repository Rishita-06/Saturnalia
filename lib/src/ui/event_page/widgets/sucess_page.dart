import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/ui/widgets/custom_button.dart';

import '../../widgets/custom_scaffold.dart';

@RoutePage()
class SucessPage extends ConsumerStatefulWidget {
  const SucessPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SucessPageState();
}

class _SucessPageState extends ConsumerState<SucessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(
          (route) => route.data!.name == 'EventRoute',
        );
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset(
                    'assets/images/ic_done.png',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'CONGRATS!',
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
                    'You have successfully registered for the Event',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You Got ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                       Text(
                        '+40',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        ' coins',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 200,
                      onTap: () {
                        Navigator.of(context).popUntil(
                          (route) => route.data!.name == 'EventRoute',
                        );
                      },
                      text: 'Let\'s Go',
                      isProcessing: false,
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
