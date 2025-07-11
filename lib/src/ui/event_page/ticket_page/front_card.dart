// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:Saturnalia/src/models/event_details.dart';
// import 'package:Saturnalia/src/models/event_user_data.dart';
// import 'package:dotted_line/dotted_line.dart';

// import '../../../utils/time_utils.dart';

// class FrontCard extends ConsumerWidget {
//   final EventDetails eventDetails;
//   final EventUserData eventUserData;
//   const FrontCard({
//     super.key,
//     required this.eventDetails,
//     required this.eventUserData,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//         vertical: 15,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: CachedNetworkImage(
//               imageUrl: eventDetails.details.imageUrl ?? '',
//               errorWidget: (context, url, error) => Image.asset(
//                 'assets/images/event_image.png',
//                 height: 180,
//                 fit: BoxFit.fill,
//                 color: Colors.black.withOpacity(0.4),
//                 colorBlendMode: BlendMode.darken,
//               ),
//               height: 180,
//               fit: BoxFit.fill,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: Text(
//               eventDetails.details.title,
//               style: GoogleFonts.outfit(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Name:',
//                       style: GoogleFonts.outfit(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       eventUserData.name,
//                       style: GoogleFonts.outfit(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Registration No:',
//                       style: GoogleFonts.outfit(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       '${eventUserData.tokenId.split('-')[0]}-XXXX',
//                       style: GoogleFonts.outfit(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Date of Event:',
//                       style: GoogleFonts.outfit(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       prettyTimeStamp5(eventDetails.details.eventDate),
//                       style: GoogleFonts.outfit(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Time of Event:',
//                       style: GoogleFonts.outfit(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       prettyTimeStamp4(eventDetails.details.eventDate),
//                       style: GoogleFonts.outfit(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Location:',
//                 style: GoogleFonts.outfit(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 eventDetails.details.venue,
//                 style: GoogleFonts.outfit(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           const DottedLine(
//             direction: Axis.horizontal,
//             alignment: WrapAlignment.spaceEvenly,
//             lineLength: double.infinity,
//             lineThickness: 1.5,
//             dashLength: 10.0,
//             dashColor: Colors.white,
//             dashGapLength: 8.0,
//             dashGapColor: Colors.transparent,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Center(
//             child: Text(
//               'Tap on the ticket to show QR code',
//               style: GoogleFonts.outfit(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }
