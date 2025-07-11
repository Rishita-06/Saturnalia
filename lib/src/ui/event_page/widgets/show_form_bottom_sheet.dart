// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:Saturnalia/src/models/form_data.dart';
// import 'package:Saturnalia/src/utils/toast_utils.dart';

// import '../../../constants/colors.dart';
// import '../../../utils/dialog_utils.dart';
// import '../../../utils/web_utils.dart';
// import '../event_page_model.dart';

// showFormBottomSheet(
//   BuildContext context,
//   WidgetRef ref,
//   FormData formData,
//   BuildContext mainContext,
// ) {
//   return showSaturnaliaBottomSheet(
//     context: context,
//     builder: (context) => FormBottomSheet(
//       formData: formData,
//       mainContext: mainContext,
//     ),
//   );
// }

// class FormBottomSheet extends ConsumerWidget {
//   final FormData formData;
//   final BuildContext mainContext;
//   const FormBottomSheet({
//     required this.formData,
//     required this.mainContext,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xff181818),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 22),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 'Follow this step to Register',
//                 style: GoogleFonts.outfit(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 19, left: 5),
//                 child: Text(
//                   '. Fill this form to receive a Registration ID',
//                   style: GoogleFonts.outfit(
//                     fontSize: 16,
//                     color: Colors.white.withOpacity(0.7),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Consumer(
//                 builder: (context, ref, _) => GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     Navigator.pop(context);
//                     // openUrl(formData.googleFormUrl);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       padding: const EdgeInsets.only(
//                         right: 20,
//                         left: 20,
//                         top: 12,
//                         bottom: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0x1A000000),
//                             offset: Offset(0, 4),
//                             blurRadius: 18,
//                             spreadRadius: 0,
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Open Google Form',
//                           style: GoogleFonts.outfit(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 25, left: 5),
//                 child: Text(
//                   '. Enter the Registration ID sent on your email',
//                   style: GoogleFonts.outfit(
//                     fontSize: 16,
//                     color: Colors.white.withOpacity(0.7),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Consumer(
//                 builder: (mainContext, ref, _) => GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     Navigator.pop(context);
//                     showRegistrationBottomSheet(mainContext, ref, formData);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       padding: const EdgeInsets.only(
//                         right: 20,
//                         left: 20,
//                         top: 12,
//                         bottom: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0x1A000000),
//                             offset: Offset(0, 4),
//                             blurRadius: 18,
//                             spreadRadius: 0,
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Enter Registration ID',
//                           style: GoogleFonts.outfit(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//             ]),
//       ),
//     );
//   }
// }

// showRegistrationBottomSheet(
//   BuildContext context,
//   WidgetRef ref,
//   FormData formData,
// ) {
//   return showSaturnaliaBottomSheet(
//     context: context,
//     builder: (context) => RegistrationBottomSheet(
//       formData: formData,
//     ),
//   )..whenComplete(
//       () => ref.read(eventPageProvider.notifier).setRegistrationId(null),
//     );
// }

// class RegistrationBottomSheet extends ConsumerStatefulWidget {
//   final FormData formData;

//   const RegistrationBottomSheet({
//     required this.formData,
//     super.key,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _RegistrationBottomSheetState();
// }

// class _RegistrationBottomSheetState
//     extends ConsumerState<RegistrationBottomSheet> {
//   bool isProcessing = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xff181818),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 20,
//           right: 20,
//         ),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 'Enter Registration ID',
//                 style: GoogleFonts.outfit(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const _EnterRegistrationIdTextField(),
//               const SizedBox(
//                 height: 40,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Consumer(
//                   builder: (context, ref, _) => GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () async {
//                       setState(() {
//                         isProcessing = true;
//                       });
//                       final res = await ref
//                           .read(eventPageProvider.notifier)
//                           .registerForEvents(
//                               widget.formData.isGoogleForm,
//                               widget.formData.hashCode1,
//                               widget.formData.hashCode2);
//                       if (res != '') {
//                         showErrorMessage(context, res);
//                       } else {
//                         // Navigator.pop(context);
//                       }
//                       setState(() {
//                         isProcessing = false;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.only(
//                         right: 30,
//                         left: 30,
//                         top: 12,
//                         bottom: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0x1A000000),
//                             offset: Offset(0, 4),
//                             blurRadius: 18,
//                             spreadRadius: 0,
//                           ),
//                         ],
//                       ),
//                       child: isProcessing
//                           ? const Center(
//                               child: SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             )
//                           : Text(
//                               'Register',
//                               style: GoogleFonts.outfit(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: Text(
//                   'Note: Please ensure that you fill the form with the same email address you used to login to the app with.',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.outfit(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//             ]),
//       ),
//     );
//   }
// }

// class _EnterRegistrationIdTextField extends ConsumerStatefulWidget {
//   const _EnterRegistrationIdTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   ConsumerState<_EnterRegistrationIdTextField> createState() =>
//       _EnterRegistrationIdTextFieldState();
// }

// class _EnterRegistrationIdTextFieldState
//     extends ConsumerState<_EnterRegistrationIdTextField> {
//   final TextEditingController controller = TextEditingController();
//   final FocusNode focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             spreadRadius: 0,
//             blurRadius: 18,
//             offset: const Offset(0, 4),
//             color: Colors.black.withOpacity(.1),
//           ),
//         ],
//         color: const Color(0xff333333),
//       ),
//       child: TextField(
//         focusNode: focusNode,
//         textAlignVertical: TextAlignVertical.center,
//         controller: controller,
//         keyboardType: TextInputType.number,
//         style: GoogleFonts.outfit(
//           fontSize: 15,
//           color: Colors.white,
//           fontStyle: FontStyle.normal,
//           fontWeight: FontWeight.w400,
//         ),
//         scrollPadding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).size.height),
//         maxLength: 12,
//         textInputAction: TextInputAction.search,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         decoration: InputDecoration(
//           filled: true,
//           counterText: '',
//           fillColor: const Color(0xff333333),
//           hintText: 'Registration ID',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.only(
//             left: 15,
//             right: 15,
//           ),
//           hintStyle: GoogleFonts.outfit(
//             fontSize: 15,
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w400,
//             color: Colors.white.withOpacity(0.5),
//           ),
//         ),
//         onChanged: (value) {
//           ref.read(eventPageProvider.notifier).setRegistrationId(value);
//         },
//       ),
//     );
//   }
// }

// copyToClipboard(String userEmail) async {
//   await Clipboard.setData(
//     ClipboardData(text: userEmail),
//   );
//   Fluttertoast.showToast(
//     msg: 'Form Link copied to clipboard!',
//     backgroundColor: primaryColor,
//     textColor: Colors.white,
//   );
// }
