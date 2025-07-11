import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../logic/repositories/events_repository/events_respository.dart';
import '../../../utils/time_utils.dart';
import '../../widgets/custom_button.dart';
import '../qr_scanner_model.dart';

class AlreadyScannedSection extends ConsumerWidget {
  final String eventId;
  const AlreadyScannedSection({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(
      qrScannerPageProvider.select((_) => _.data),
    );

    final eventData = ref.watch(eventsPageProvider.select((value) => value
        .allPublicEvents!
        .firstWhere((element) => element.details.eventId == eventId)));
    return Column(
      children: [
        SizedBox(
          height: 260,
          child: Transform.scale(
            scale: 3,
            child: Lottie.asset(
              'assets/lottie/ic_already_scanned.json',
              repeat: false,
            ),
          ),
        ),
        Text(
          'QR Already Scanned!',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 18,
            color: const Color(0xffFFB553),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          eventData.details.title,
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          userData?.name??'',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scanned Date',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          prettyTimeStamp9(userData?.verificationTime),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scanned By',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          userData?.email??'',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Email',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          userData?.userEmail??'',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
          ),
        ),
      ],
    );
  }
}
