import 'package:Saturnalia/src/ui/widgets/custom_sat_drop_down.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/routing/router.dart';

import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../../../../constants/colors.dart';
import '../add_event_model.dart';
import '../../../widgets/add_date_section.dart';
import 'event_text_field.dart';

class RegistrationDetailsSection extends ConsumerStatefulWidget {
  const RegistrationDetailsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationDetailsSectionState();
}

class _RegistrationDetailsSectionState
    extends ConsumerState<RegistrationDetailsSection> {
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(
      addEventModelProvider.select((_) => _.registrationType),
    );
    final startDate = ref.watch(
      addEventModelProvider.select(
        (_) => _.startDate,
      ),
    );
    final endDate = ref.watch(
      addEventModelProvider.select(
        (_) => _.endDate,
      ),
    );
    final eventDate = ref.watch(
      addEventModelProvider.select((_) => _.eventDate),
    );
    final formData = ref.watch(
      addEventModelProvider.select((_) => _.fieldList),
    );
    final eventType = ref.watch(
      addEventModelProvider.select((_) => _.eventType),
    );

    return type == 3
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Type',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomSatDropDownButton<int>(
                  width: 300,
                  backgroundColor: secondaryContainerColor,
                  selectedId: eventType,
                  onChanged: (value) {
                    ref
                        .read(addEventModelProvider.notifier)
                        .setEventType(value);
                  },
                  data: const [
                    {1: 'View All'},
                    {9: "External Registration"},
                    {2: 'View Only For Thapar'},
                    {3: 'For Participation Only'},
                    {4: 'Open Participation For Now'},
                    {5: "Open Participation & View for thapar "},
                    {6: "Open Participation & View For Everyone"},
                    {7: 'Close Partcipation & View Only For thapar'},
                    {8: 'Close Partcipation & View for everyone'},
                  ]),
              const SizedBox(
                height: 20,
              ),
              EventTextField(
                hintText: 'min team size allowed',
                label: 'Team Minimum Size',
                isDigitOnly: true,
                onChanged: (value) {
                  ref.read(addEventModelProvider.notifier).setTeamMinSize(
                      value.trim().isEmpty ? 0 : int.parse(value));
                },
                initialText: ref.read(addEventModelProvider
                    .select((value) => value.teamMinSize.toString())),
                maxLength: 2,
              ),
              const SizedBox(height: 20),
              EventTextField(
                hintText: 'max team size allowed',
                label: 'Team Maximum Size',
                isDigitOnly: true,
                onChanged: (value) {
                  ref.read(addEventModelProvider.notifier).setTeamMaxSize(
                      value.trim().isEmpty ? 0 : int.parse(value));
                },
                initialText: ref.read(addEventModelProvider
                    .select((value) => value.teamMaxSize.toString())),
                maxLength: 2,
              ),
              const SizedBox(height: 20),
              AddDateSection(
                label: 'Start Date',
                onTap: () {
                  if (eventDate == null) {
                    showErrorMessage(context, 'Please select EventDate First');
                    return false;
                  }
                  return true;
                },
                onChanged: (value) {
                  if (eventDate == null) {
                    return;
                  }
                  if (value == null) {
                    return;
                  }
                  if (value.compareTo(eventDate) > 0) {
                    showErrorMessage(context, 'Invalid Start Date');
                    return;
                  }

                  ref.read(addEventModelProvider.notifier).setStartDate(value);
                },
                dateTime: startDate,
              ),
              const SizedBox(height: 20),
              AddDateSection(
                label: 'End Date',
                onTap: () {
                  if (eventDate == null) {
                    showErrorMessage(context, 'Please select EventDate First');
                    return false;
                  }
                  return true;
                },
                onChanged: (value) {
                  if (eventDate == null) {
                    return;
                  }
                  if (value == null) {
                    return;
                  }
                  if (value.compareTo(eventDate) > 0) {
                    showErrorMessage(context, 'Invalid End Date');
                    return;
                  }

                  ref.read(addEventModelProvider.notifier).setEndDate(value);
                },
                dateTime: endDate,
              ),
              const SizedBox(height: 20),
              if (type == 2) ...[
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final teamMinSize = ref.read(addEventModelProvider
                            .select((value) => value.teamMinSize));
                        final teamMaxSize = ref.read(addEventModelProvider
                            .select((value) => value.teamMaxSize));
                        if (teamMinSize == 0 || teamMaxSize == 0) {
                          showErrorMessage(
                              context, 'please enter team size first');
                          return;
                        } else if (teamMinSize > teamMaxSize) {
                          showErrorMessage(
                              context, 'team max size should be greater!');
                          return;
                        }
                        context.navigateTo(CreateFormRoute(
                            data: formData.isEmpty ? null : formData,
                            minSize: teamMinSize,
                            maxSize: teamMaxSize));
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 8,
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              formData.isNotEmpty ? 'Edit Form' : 'Create Form',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          );
  }
}
