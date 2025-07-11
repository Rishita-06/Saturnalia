// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/manage_events/add_event/widgets/add_link_section.dart';

import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../../../constants/colors.dart';
import '../../widgets/custom_sat_drop_down.dart';
import 'add_event_model.dart';
import '../../widgets/add_date_section.dart';
import 'widgets/add_images_section.dart';
import 'widgets/add_tags.dart';
import 'widgets/event_text_field.dart';
import 'widgets/registration_details_section.dart';
import 'widgets/registration_type_section.dart';
import 'widgets/venue_drop_down.dart';

@RoutePage()
class AddEventPage extends ConsumerStatefulWidget {
  final EventDetails? eventData;
  const AddEventPage({
    super.key,
    this.eventData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEventPageState();
}

class _AddEventPageState extends ConsumerState<AddEventPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.eventData != null) {
        ref.read(addEventModelProvider.notifier).init(widget.eventData!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationList = ref.watch(
      eventsPageProvider.select((_) => _.locationData),
    );
    final selectedLocation = ref.watch(
      addEventModelProvider.select((_) => _.location),
    );

    final eventDate = ref.watch(
      addEventModelProvider.select((_) => _.eventDate),
    );

    final eventEndDate = ref.watch(
      addEventModelProvider.select((_) => _.eventEndDate),
    );
    final eventVisibility = ref.watch(
      addEventModelProvider.select((_) => _.eventVisibility),
    );

    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.eventData != null ? 'edit' : 'add',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: ' Event',
                          style: GoogleFonts.outfit(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  EventTextField(
                    maxLength: 50,
                    initialText: ref.read(
                      addEventModelProvider.select(
                        (_) => _.eventTitle,
                      ),
                    ),
                    onChanged: (value) {
                      ref
                          .read(addEventModelProvider.notifier)
                          .setEventName(value);
                    },
                    label: 'Name of the Event',
                    hintText: 'Event Name',
                  ),
                  const SizedBox(height: 20),
                  const AddTags(),
                  const SizedBox(height: 20),
                  Text(
                    'Event Visibility',
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
                      selectedId: eventVisibility,
                      initialText: 'Select',
                      onChanged: (value) {
                        ref
                            .read(addEventModelProvider.notifier)
                            .setEventVisibility(value);
                      },
                      data: const [
                        {1: 'For Thapar Only'},
                        {2: 'For Externals Only'},
                        {3: 'Open For All'},
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  AddDateSection(
                    onTap: () {
                      return true;
                    },
                    label: 'Event Date ',
                    onChanged: (value) {
                      ref
                          .read(addEventModelProvider.notifier)
                          .setEventDate(value);
                    },
                    dateTime: eventDate,
                  ),
                  const SizedBox(height: 20),
                  AddDateSection(
                    onTap: () {
                      return true;
                    },
                    label: 'Event End Date ',
                    onChanged: (value) {
                      ref
                          .read(addEventModelProvider.notifier)
                          .setEventEndDate(value);
                    },
                    dateTime: eventEndDate,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Venue',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VenueDropDownButton<int>(
                        selectedId: selectedLocation,
                        onChanged: (value) {
                          ref
                              .read(addEventModelProvider.notifier)
                              .setLocation(value);
                        },
                        initialText: 'Venue',
                        data: (locationList ?? [])
                            .map((e) => {
                                  e.id: e.venue.toString(),
                                })
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EventTextField(
                      hintText: 'T101 Tan Building',
                      label: 'Venue Name',
                      onChanged: (value) {
                        ref
                            .read(addEventModelProvider.notifier)
                            .setVenueName(value);
                      },
                      initialText: ref.read(
                        addEventModelProvider.select((_) => _.venueName),
                      ),
                      maxLength: null),
                  const SizedBox(height: 20),
                  DescriptionTextField(
                    initialText: ref.read(
                      addEventModelProvider.select((_) => _.description),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RegistrtationTextField(
                    initialText: ref.read(
                      addEventModelProvider
                          .select((_) => _.registrationProcess),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RulesTextField(
                    initialText: ref.read(
                      addEventModelProvider.select((_) => _.rulesAndRegulation),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TermsTextField(
                    initialText: ref.read(
                      addEventModelProvider.select((_) => _.termsAndCondition),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PointTextField(
                    initialText: ref.read(
                      addEventModelProvider.select((_) => _.pointOfContact),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AddImagesSection(),
                  const SizedBox(height: 20),
                  const AddLinkSection(),
                  const SizedBox(height: 20),
                  const RegistrationTypeSection(),
                  const SizedBox(height: 20),
                  const RegistrationDetailsSection(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      final res = await ref
                          .read(addEventModelProvider.notifier)
                          .addEvent();
                      if (res != '') {
                        showErrorMessage(context, res);
                      } else {
                        final data = ref.read(
                          addEventModelProvider.select((_) => _.eventData),
                        );
                        if (data == null) {
                          showErrorMessage(context, 'Incomplete Data');
                          return;
                        }
                        context.navigateTo(
                            EventRoute(data: data, isPreview: true));
                      }
                    },
                    child: Container(
                      height: 50,
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
                      child: Center(
                        child: Text(
                          'Preview',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
