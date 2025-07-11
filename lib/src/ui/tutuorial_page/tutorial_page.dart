import 'dart:io';

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/services/preference_service.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class TutorialPage extends ConsumerStatefulWidget {
  const TutorialPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TutorialPageState();
}

class _TutorialPageState extends ConsumerState<TutorialPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).height,
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 1 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/1.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 2 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/2.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 3 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/3.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 4 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/4.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 5 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/5.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 6 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/6.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 7 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/7.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 8 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/8.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 9 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/9.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 10 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/10.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                          height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 11 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/11.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 80,
                child: Transform.scale(
                  scale: 0.75,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: secondaryContainerColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: index == 12 ? 1 : 0,
                        child: Image.asset(
                          'assets/tutorials/12.png',
                          width: MediaQuery.sizeOf(context).width + 10,
                           height:Platform.isIOS?MediaQuery.sizeOf(context).height-50:  MediaQuery.sizeOf(context).height + 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (index != 1) {
                                  index--;
                                }
                              });
                            },
                            child: Opacity(
                              opacity: index != 1 ? 1 : 0,
                              child: Image.asset(
                                'assets/images/ic_back.png',
                                height: 35,
                              ),
                            ),
                          ),
                          Text(
                            '$index/12',
                            style: GoogleFonts.rocknRollOne(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.rotate(
                            angle: 84.8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index != 12) {
                                    index++;
                                  }
                                });
                              },
                              child: Opacity(
                                opacity: index != 12 ? 1 : 0,
                                child: Image.asset(
                                  'assets/images/ic_back.png',
                                  height: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'Handbook',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rocknRollOne(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/ic_text2.png',
                      height: 35,
                    ),
                  ],
                ),
              ),
              // if (index != 12)
              Positioned(
                top: 25,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(sharedPreferencesProvider)
                        .setBool(PreferenceService.isFirstTime, false);
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 60),
                    height: 35,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2),
                          spreadRadius: 0,
                          color: secondaryColor,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Close',
                        style: GoogleFonts.rocknRollOne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
