import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert' as convert;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../utils/project_utils.dart';

class ProfileDialog extends ConsumerStatefulWidget {
  const ProfileDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends ConsumerState<ProfileDialog> {
  File? imageFile;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final userData = ref.read(
        appRepositoryProvider.select((_) => _.authUser),
      );
      imageFile = await getAvatarFile(
        userData?.uid ?? 'X-SLAYER',
        userData?.displayName ?? 'sat',
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.read(
      appRepositoryProvider.select((_) => _.userData),
    );
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      border: Border(
                        top: BorderSide(
                            width: 2,
                            color: userData!.gender == 1
                                ? secondaryColor
                                : primaryColor),
                        bottom: BorderSide(
                            width: 0,
                            color: userData.gender == 1
                                ? secondaryColor
                                : primaryColor),
                        left: BorderSide(
                            width: 0,
                            color: userData.gender == 1
                                ? secondaryColor
                                : primaryColor),
                        right: BorderSide(
                            width: 0,
                            color: userData.gender == 1
                                ? secondaryColor
                                : primaryColor),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(70, 50, 70, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PrettyQrView.data(
                                    decoration: const PrettyQrDecoration(
                                      shape: PrettyQrSmoothSymbol(
                                          roundFactor: 0.6),
                                      image: PrettyQrDecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo.png'),
                                        position:
                                            PrettyQrDecorationImagePosition
                                                .foreground,
                                      ),
                                    ),
                                    data: generateUniqueCode(userData.userId)
                                        .toUpperCase(),
                                    errorCorrectLevel: QrErrorCorrectLevel.L,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'User Id : ',
                                maxLines: 2,
                                style: GoogleFonts.crimsonText(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: secondaryContainerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Text(
                                    generateUniqueCode(userData.userId)
                                        .toUpperCase(),
                                    style: GoogleFonts.crimsonText(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color:
                          userData.gender == 1 ? secondaryColor : primaryColor,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: scaffoldColor,
                    child: imageFile == null
                        ? const SizedBox()
                        : SvgPicture.file(imageFile!),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }

  String generateUniqueCode(String userId) {
    final bytes = convert.utf8.encode(userId.substring(5,15));
    final hash = sha256.convert(bytes);
    return hash.toString().substring(0, 8);
  }
}
