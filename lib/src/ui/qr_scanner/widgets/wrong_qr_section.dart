import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/custom_button.dart';
import '../qr_scanner_model.dart';

class WrongQrSection extends ConsumerWidget {
  const WrongQrSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(
      qrScannerPageProvider
          .select((value) => value.errorMesaage?.toUpperCase()),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 70,
        ),
        SizedBox(
          height: 260,
          child: Lottie.asset(
            !(errorMessage == null)
                ? 'assets/lottie/ic_something_went_wrong.json'
                : 'assets/lottie/ic_wrong.json',
            repeat: !(errorMessage == null) ? true : false,
          ),
        ),
        Text(
          errorMessage ?? 'Somthing Went Wrong!',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 22,
            color: const Color(0xffFF6262),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: CustomButton(
            onTap: () {
              ref
                  .read(qrScannerPageProvider.notifier)
                  .setStatus(QrStatus.initial);
            },
            text: 'Scan Again',
            isProcessing: false,
          ),
        ),
      ],
    );
  }
}
