// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../logic/repositories/app_repository/app_repository.dart';

// import '../../widgets/custom_text.dart';
// import 'share_card.dart';

// class MoreCoinsSection extends ConsumerStatefulWidget {
//   const MoreCoinsSection({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _MoreCoinsSectionState();
// }

// class _MoreCoinsSectionState extends ConsumerState<MoreCoinsSection> {
//   @override
//   Widget build(BuildContext context) {
//     final isThaparId = ref.watch(
//       appRepositoryProvider.select((_) => _.thaparId),
//     );
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Need More Coins ?',
//             style: GoogleFonts.outfit(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 if (isThaparId) ...[
//                   const ShareCard(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//                 CustomBulletText(
//                   'Join us at our desks & win exciting games to get extra coins.',
//                   style: GoogleFonts.outfit(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const CustomBulletText(
//                     'Register and participate in events to get coins.'),
//                 const SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
