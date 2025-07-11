import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

class AddDateSection extends ConsumerWidget {
  final String label;
  final DateTime? dateTime;
  final bool Function() onTap;
  final Function(DateTime? value) onChanged;
  const AddDateSection({
    super.key,
    required this.dateTime,
    required this.label,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            final value = onTap();
            if (!value) {
              return;
            }
            DateTime? dateTimeList = await showOmniDateTimePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime.now().add(
                const Duration(days: 365),
              ),
              is24HourMode: false,
              isShowSeconds: false,
              minutesInterval: 1,
              secondsInterval: 1,
              theme: ThemeData.dark(useMaterial3: true),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 680,
              ),
              transitionBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1.drive(
                    Tween(
                      begin: 0,
                      end: 1,
                    ),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
            );
            onChanged(dateTimeList);
          },
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff181818),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: secondaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          prettyTimeStamp6(dateTime),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff181818),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: secondaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          prettyTimeStamp4(dateTime),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
