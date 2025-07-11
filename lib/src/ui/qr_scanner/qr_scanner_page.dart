import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../constants/colors.dart';

import '../../logic/repositories/events_repository/events_respository.dart';
import '../widgets/back_button.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text.dart';
import 'qr_scanner_model.dart';
import 'widgets/already_scanned_section.dart';
import 'widgets/event_scanned_section.dart';
import 'widgets/wrong_qr_section.dart';

@RoutePage()
class QRScannnerPage extends ConsumerStatefulWidget {
  final String eventId;

  final String eventName;
  const QRScannnerPage({
    super.key,
    required this.eventId,
    required this.eventName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRScannnerPageState();
}

class _QRScannnerPageState extends ConsumerState<QRScannnerPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(qrScannerPageProvider.notifier).setEventId(
            widget.eventId,
            widget.eventName,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      qrScannerPageProvider.select((_) => _.status),
    );
    final userData = ref.watch(
      qrScannerPageProvider.select((_) => _.data),
    );
    final eventData = ref.watch(eventsPageProvider.select((value) => value
        .allPublicEvents!
        .firstWhere((element) => element.details.eventId == widget.eventId)));

    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    CustomBackButton(),
                    SizedBox(width: 10),
                    CustomText2(
                      'Scan Qr Code',
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                if (!eventData.details.scanningStarted) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        height: 260,
                        child: Lottie.asset(
                          'assets/lottie/ic_something_went_wrong.json',
                          repeat: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Text(
                          'Qr scanning process not started yet!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ] else if (status == QrStatus.initial) ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          painter: CustomBorderPainter(30),
                          child: SizedBox(
                            height: 260,
                            width: 260,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: MobileScanner(
                                  controller: MobileScannerController(
                                    detectionSpeed: DetectionSpeed.normal,
                                    facing: CameraFacing.back,
                                    torchEnabled: false,
                                  ),
                                  onDetect: (capture) async {
                                    final List<Barcode> barcodes =
                                        capture.barcodes;

                                    for (final barcode in barcodes) {
                                      // debugPrint(
                                      //     'Barcode found! ${barcode.rawValue}');
                                      await ref
                                          .read(qrScannerPageProvider.notifier)
                                          .processQr(barcode.rawValue);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ] else if (status == QrStatus.processing) ...[
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else if (status == QrStatus.processedAndVerified &&
                    userData != null) ...[
                  EventScannedSection(eventId: widget.eventId),
                ] else if (status == QrStatus.processedAlreadyVerified) ...[
                  AlreadyScannedSection(eventId: widget.eventId),
                ] else ...[
                  const WrongQrSection(),
                ],
              ]),
        ),
      ),
    );
  }
}

class CustomBorderPainter extends CustomPainter {
  final double length;

  CustomBorderPainter(this.length);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Top border
    canvas.drawLine(const Offset(0, 0), Offset(0, length), paint);
    canvas.drawLine(const Offset(0, 0), Offset(length, 0), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - length), paint);
    canvas.drawLine(Offset(0, size.height), Offset(length, size.height), paint);

    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - length), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - length, size.height), paint);

    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - length, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, length), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
