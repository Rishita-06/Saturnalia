// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/models/form_data.dart';

import 'package:Saturnalia/src/models/team_data.dart';
import 'package:Saturnalia/src/ui/form_page/widgets/add_team_member.dart';

import 'package:Saturnalia/src/ui/store/widgets/team_data_card.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/models/dynamic_form_data.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/ui/form_page/form_page_model.dart';
import 'package:Saturnalia/src/ui/manage_events/add_event/add_event_model.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_sat_drop_down.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../../constants/colors.dart';

import '../create/widgets/custom_drop_down.dart';
import '../widgets/corousal_widget.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class FormPage extends ConsumerStatefulWidget {
  final FormData data;
  final String registrationProcess;
  final String rulesAndRegulation;
  final bool isPreview;

  final String eventId;
  final String eventName;
  const FormPage({
    super.key,
    required this.data,
    this.isPreview = false,
    this.eventName = '',
    this.eventId = '',
    this.registrationProcess = '',
    this.rulesAndRegulation = '',
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  bool isProcessing = false;
  bool isContinue = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(formPageProvider.notifier).init(
            widget.data.data,
            widget.eventId,
            widget.eventName,
            widget.data.teamMaxSize,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(formPageProvider, (prev, next) {});
    final status = ref.watch(formPageProvider.select((value) => value.status));
    final id = ref.watch(formPageProvider.select((value) => value.participant));
    // final thaparStudent =
    //     ref.watch(appRepositoryProvider.select((value) => value.thaparId));
    final teamSize =
        ref.watch(formPageProvider.select((value) => value.teamSize));

    final teamDetails =
        ref.watch(formPageProvider.select((value) => value.teamDetails));
    return WillPopScope(
      onWillPop: () async {
        return !isProcessing;
      },
      child: SafeArea(
        child: CustomScaffold(
          body: status == FormPageStatus.loaded
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollScrollBehavior(),
                    child: SingleChildScrollView(
                      child: !isContinue
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const CustomBackButton(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: secondaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Register now for participation! Tickets for event visiting coming soon. Stay tuned for updates.',
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Pricing Policy',
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'You can check info section for pricing policy',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Registration Process',
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.registrationProcess,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Rules and Regulation',
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.rulesAndRegulation,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Row(
                                  children: [
                                    CustomBackButton(),
                                    SizedBox(width: 10),
                                    CustomText2(
                                      'fill Form',
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                // if (thaparStudent) ...[
                                //   const SizedBox(
                                //     height: 20,
                                //   ),
                                //   const _FirstField(),
                                // ],
                                const SizedBox(
                                  height: 20,
                                ),
                                if (id == 0)
                                  Column(
                                    children: widget.data.data
                                        .map(
                                          (e) => _FieldCard(e: e),
                                        )
                                        .toList(),
                                  ),
                                if (widget.data.teamMaxSize != 1) ...[
                                  CustomDropDownButton(
                                    isEnabled: !isProcessing,
                                    selectedId: teamSize,
                                    label: 'Select Team Size',
                                    initialText: 'Select',
                                    onChanged: (value) {
                                      ref
                                          .read(formPageProvider.notifier)
                                          .setTeamSize(
                                            value,
                                          );
                                    },
                                    data: List<int>.generate(
                                        widget.data.teamMaxSize -
                                            widget.data.teamMinSize +
                                            1,
                                        (i) =>
                                            widget.data.teamMinSize -
                                            1 +
                                            i +
                                            1),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (teamSize != null && teamSize != 1) ...[
                                    Text(
                                      'Team Members',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: teamSize - 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                showAddTeamMemberBottomSheet(
                                                    context, index);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${index + 2}. ',
                                                    style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  teamDetails[index]
                                                          .email
                                                          .trim()
                                                          .isNotEmpty
                                                      ? Expanded(
                                                          child: Stack(
                                                            children: [
                                                              TeamDataCard(
                                                                data: TeamData(
                                                                  userId: teamDetails[
                                                                          index]
                                                                      .userId,
                                                                  userName:
                                                                      teamDetails[
                                                                              index]
                                                                          .name,
                                                                  email: teamDetails[
                                                                          index]
                                                                      .email,
                                                                  graduationYear:
                                                                      '2026',
                                                                  phoneNumber:
                                                                      232345,
                                                                  gender: 1,
                                                                  coins: 10,
                                                                  roleId: 2,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    if (!isProcessing) {
                                                                      ref
                                                                          .read(formPageProvider
                                                                              .notifier)
                                                                          .removeTeamMember(
                                                                              index);
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Container(
                                                            height: 50,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  secondaryContainerColor,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Select Team Member ${index + 2}',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              )),
                                        );
                                      },
                                    ),
                                  ],
                                ],
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                    ),
                  ),
                )
              : TryAgainWidget(
                  onTap: () {},
                  isProcessing: status == FormPageStatus.loading ||
                      status == FormPageStatus.initial),
          bottomBar: status == FormPageStatus.loaded
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // if (widget.data.teamMaxSize != 1 && !isContinue && id != 1)
                      //   CustomButton(
                      //     width: 120,
                      //     onTap: () async {
                      //       if (!isContinue) {
                      //         showDeleteConfirmationPopup(context,
                      //             title:
                      //                 'Are you sure you want to join a team ??',
                      //             onCancel: () {},
                      //             isProcessing: false, onConfirm: () async {
                      //           setState(() {
                      //             isContinue = true;

                      //             ref
                      //                 .read(formPageProvider.notifier)
                      //                 .setParticipant(1);
                      //           });
                      //           context.maybePop();
                      //         });

                      //         return;
                      //       }
                      //       if (!isProcessing) {
                      //         if (widget.isPreview) {
                      //           ref
                      //               .read(addEventModelProvider.notifier)
                      //               .setFormData(widget.data.data);
                      //           Navigator.of(context).popUntil((route) =>
                      //               route.data!.name == 'AddEventRoute');
                      //         } else {
                      //           setState(() {
                      //             isProcessing = true;
                      //           });
                      //           final res = await ref
                      //               .read(formPageProvider.notifier)
                      //               .registerForEvents();
                      //           if (res != '') {
                      //             showErrorMessage(context, res);
                      //             setState(() {
                      //               isProcessing = false;
                      //             });
                      //           } else {
                      //             context.navigateTo(const SucessRoute());
                      //           }
                      //         }
                      //       }
                      //     },
                      //     text: 'Join Team ',
                      //     isProcessing: isProcessing,
                      //   ),
                      // if (id != 1)
                      CustomButton(
                        width: 140,
                        onTap: () async {
                          if (!isContinue) {
                            setState(() {
                              isContinue = true;
                            });
                            return;
                          }
                          if (!isProcessing) {
                            if (widget.isPreview) {
                              ref
                                  .read(addEventModelProvider.notifier)
                                  .setFormData(widget.data.data);
                              Navigator.of(context).popUntil((route) =>
                                  route.data!.name == 'AddEventRoute');
                            } else {
                              setState(() {
                                isProcessing = true;
                              });
                              final res = await ref
                                  .read(formPageProvider.notifier)
                                  .registerForEvents();
                              if (res != '') {
                                showErrorMessage(context, res);
                                setState(() {
                                  isProcessing = false;
                                });
                              } else {
                                context.navigateTo(const SucessRoute());
                              }
                            }
                          }
                        },
                        text: !isContinue
                            ? 'Continue'
                            : widget.isPreview
                                ? 'Save Form'
                                : 'Submit form',
                        isProcessing: isProcessing,
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _FieldCard extends ConsumerStatefulWidget {
  final DyamicFormData e;
  const _FieldCard({super.key, required this.e});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FieldCardState();
}

class __FieldCardState extends ConsumerState<_FieldCard> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return widget.e.type != 4
        ? widget.e.type != 5
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomTextField(
                  isShowMaxLength: widget.e.data.maxLength == null
                      ? false
                      : widget.e.type == 1,
                  hintText: widget.e.data.title,
                  label: widget.e.data.title,
                  onChanged: (value) {
                    ref
                        .read(formPageProvider.notifier)
                        .updateValue(widget.e.id, value);
                  },
                  initialText: ref.read(formPageProvider.select((value) => value
                          .responses
                          ?.firstWhere((element) => element.id == widget.e.id)
                          .value)) ??
                      '',
                  maxLength: widget.e.type == 1
                      ? widget.e.data.maxLength
                      : widget.e.type == 0
                          ? 99
                          : widget.e.type == 3
                              ? 20
                              : null,
                  maxlines: widget.e.type == 2 || widget.e.type == 0
                      ? 1
                      : widget.e.data.maxLines,
                  isDigitOnly: widget.e.type == 3,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.e.data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ref.watch(formPageProvider.select((value) => value.responses
                              ?.firstWhere(
                                  (element) => element.id == widget.e.id)
                              .value)) !=
                          ''
                      ? Stack(
                          children: [
                            CorousalWidget(
                              imageUrl: ref.read(formPageProvider.select(
                                  (value) => value.responses!
                                      .firstWhere((element) =>
                                          element.id == widget.e.id)
                                      .value)),
                              height: 160,
                              width: 115,
                            ),
                            Positioned(
                              top: 15,
                              left: 110,
                              child: GestureDetector(
                                onTap: () {
                                  if (!isProcessing) {
                                    ref
                                        .read(formPageProvider.notifier)
                                        .updateValue(widget.e.id, '');
                                  }
                                },
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (!(isProcessing)) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  final res = await ref
                                      .read(formPageProvider.notifier)
                                      .pickFile(widget.e.id);
                                  if (res != '') {
                                    showErrorMessage(context, res);
                                    setState(() {
                                      isProcessing = false;
                                    });
                                  } else {
                                    isProcessing = false;
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryContainerColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 120,
                                width: 120,
                                child: isProcessing
                                    ? Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white.withOpacity(0.6),
                                          size: 40,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )
                ],
              )
        : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.e.data.title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (widget.e.data.hint.trim().isNotEmpty) ...[
                      const SizedBox(
                        width: 10,
                      ),
                      Tooltip(
                        message: widget.e.data.hint,
                        triggerMode: TooltipTriggerMode.tap,
                        child: const Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomSatDropDownButton<int>(
                  width: MediaQuery.sizeOf(context).width,
                  backgroundColor: containerColor,
                  selectedId: ref.watch(formPageProvider.select((value) => value.responses)) ==
                              null ||
                          (ref.watch(formPageProvider.select((value) => value.responses
                                  ?.firstWhere(
                                      (elemt) => elemt.id == widget.e.id)
                                  .value))) ==
                              ''
                      ? null
                      : widget.e.data.options!
                          .firstWhere((element) =>
                              element.optionValue ==
                              (ref.watch(formPageProvider.select((value) => value
                                  .responses
                                  ?.firstWhere((elemt) => elemt.id == widget.e.id)
                                  .value))))
                          .id,
                  initialText: 'Select',
                  onChanged: (value) {
                    ref.read(formPageProvider.notifier).updateValue(
                        widget.e.id,
                        widget.e.data.options!
                            .firstWhere((el) => el.id == value)
                            .optionValue);
                  },
                  data: widget.e.data.options!
                      .map((e) => {e.id: e.optionValue})
                      .toList(),
                ),
              ],
            ),
          );
  }
}

class _FirstField extends ConsumerStatefulWidget {
  const _FirstField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FirstFieldState();
}

class __FirstFieldState extends ConsumerState<_FirstField> {
  @override
  Widget build(BuildContext context) {
    final id = ref.watch(formPageProvider.select((value) => value.participant));

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you a participant ?',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomSatDropDownButton<int>(
              width: MediaQuery.sizeOf(context).width,
              backgroundColor: containerColor,
              selectedId: id,
              initialText: 'Select',
              onChanged: (value) {
                print(value);
                ref.read(formPageProvider.notifier).setParticipant(value);
              },
              data: const [
                {0: "Yes"},
                {1: "No"}
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
