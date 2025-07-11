import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/models/event_data.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/strings.dart';
import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../models/form_data.dart';
import '../../../utils/project_utils.dart';

class NameSection extends ConsumerWidget {
  final EventData data;
  final FormData? formData;
  final int registrationType;
  const NameSection({
    super.key,
    required this.data,
    required this.formData,
    required this.registrationType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralCode = ref.watch(
      appRepositoryProvider.select((_) => _.userData?.referalCode),
    );
    final isThaparId = ref.watch(
      appRepositoryProvider.select((_) => _.thaparId),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title.toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.rocknRollOne(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  registrationType == 9
                      ? "Registration will be done on external platform"
                      : formData == null
                          ? 'Registration Will Start Soon'
                          : formData!.startDate.compareTo(DateTime.now()) > 0
                              ? 'Registrations starts on ${prettyTimeStamp2(formData!.startDate)}'
                              : formData!.endDate.compareTo(DateTime.now()) < 0
                                  ? 'Registration Closed 😔'
                                  : 'Registrations Ends on ${prettyTimeStamp2(formData!.endDate)} ${prettyTimeStamp4(formData!.endDate)}',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(.49),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              final box = context.findRenderObject() as RenderBox?;
              Share.shareXFiles(
                  [(await assetToXFile('assets/images/logo.png'))!],
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                  text:
                      '*${data.title}*\n\n${data.description.substring(0, data.description.length > 100 ? 100 : data.description.length)}...\n$storeUrl\n\nDownload the *Saturnalia App* now.\n${isThaparId ? ' Use the referral given below to get *+10 reward coins.*\n\n*REFERRAL CODE* : * $referralCode*' : ''}');
            },
            child: Image.asset(
              'assets/images/ic_share.png',
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}
