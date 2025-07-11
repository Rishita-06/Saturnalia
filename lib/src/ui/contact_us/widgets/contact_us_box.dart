import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/ui/contact_us/contact_us_model.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/contact_us_data.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';

class ContactUsBox extends ConsumerStatefulWidget {
  final ContactUsData data;
  const ContactUsBox({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactUsBoxState();
}

class _ContactUsBoxState extends ConsumerState<ContactUsBox> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoOverscrollScrollBehavior(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  CustomBackButton(),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText2(
                    'Contact Us',
                    size: 28,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                widget.data.userName,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Email',
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
                widget.data.email,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Phone Number',
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
                widget.data.mobile.toString(),
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Query Title',
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
                        '${widget.data.eventId} Issue',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Issue Status',
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
                !widget.data.issue?'Pending':'Resolved',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submission TIme',
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
                prettyTimeStamp9(widget.data.time),
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
                    ],
                  ),
                  TweenAnimationBuilder<Duration>(
                        duration:
                            prettyTimeStamp3(widget.data.time.add(Duration(days: 1))),
                        tween: Tween(
                            begin:
                                prettyTimeStamp3(widget.data.time.add(const Duration(days: 1))),
                            end: Duration.zero),
                        onEnd: () {
                          ref.read(contactUsPageProvider.notifier).init();
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                    
                          final hours = (value.inHours % 24) < 10
                              ? '0${(value.inHours % 24)}'
                              : (value.inHours % 24);
                          final minutes = (value.inMinutes % 60) < 10
                              ? '0${(value.inMinutes % 60)}'
                              : (value.inMinutes % 60);
                          final seconds = (value.inSeconds % 60) < 10
                              ? '0${(value.inSeconds % 60)}'
                              : (value.inSeconds % 60);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Raise Query Again After',
                                 style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.6),
                        ),
                              ),
                              Text(
                                '$hours : $minutes : $seconds',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                              ),
                            ],
                          );
                        },
                      ),
                
                ],
              ),
             
              const SizedBox(
                height: 20,
              ),
              Text(
                'Query',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 300),
                decoration: BoxDecoration(
                  color: containerColor,
                  border: Border.all(
                      color: secondaryColor.withOpacity(0.5), width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.data.description.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
