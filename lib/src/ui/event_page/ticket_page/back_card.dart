// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:Saturnalia/src/utils/time_utils.dart';

// import '../event_page_model.dart';

// class BackCard extends ConsumerWidget {
//   const BackCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final status = ref.watch(
//       eventPageProvider.select((_) => _.status),
//     );
//     final eventUserData = ref.watch(
//       eventPageProvider.select((_) => _.data),
//     );
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//         vertical: 30,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: Text(
//               'QR Code',
//               style: GoogleFonts.outfit(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: PrettyQrView.data(
//                     decoration: const PrettyQrDecoration(
//                       shape: PrettyQrSmoothSymbol(roundFactor: 0.6),
//                     ),
//                     data: eventUserData!.tokenId,
//                     errorCorrectLevel: QrErrorCorrectLevel.L,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           if (status != EventStatus.verified) ...[
//             Center(
//               child: Text(
//                 'Use the QR Code for a quicker access',
//                 style: GoogleFonts.outfit(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ] else if (status == EventStatus.verified) ...[
//             Center(
//               child: Text(
//                 'Qr Scanned Succefully',
//                 style: GoogleFonts.outfit(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Verified By:',
//                         style: GoogleFonts.outfit(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         eventUserData.verifiedBy ?? "",
//                         style: GoogleFonts.outfit(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Verification Time:',
//                         style: GoogleFonts.outfit(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         eventUserData.verificationTime == null
//                             ? ''
//                             : prettyTimeStamp4(eventUserData.verificationTime),
//                         style: GoogleFonts.outfit(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ]
//         ],
//       ),
//     );
//   }
// }
