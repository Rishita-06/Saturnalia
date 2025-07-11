// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/utils/web_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Saturnalia/src/ui/widgets/custom_button.dart';

import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../../../constants/colors.dart';
import '../../../models/event_details.dart';

import '../../../routing/router.dart';
import '../../../utils/network_utils.dart';

import '../event_page_model.dart';

class BottomButtons extends ConsumerStatefulWidget {
  final EventDetails eventData;

  const BottomButtons({
    super.key,
    required this.eventData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends ConsumerState<BottomButtons> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final isThaparId =
        ref.watch(appRepositoryProvider.select((value) => value.thaparId));
    final status = ref.watch(
      eventPageProvider.select(
        (_) => _.status,
      ),
    );
    final isPreview = ref.watch(
      eventPageProvider.select(
        (_) => _.isPreview,
      ),
    );

    final eventUserData =
        ref.watch(eventPageProvider.select((value) => value.data));

    return ((status == EventStatus.notRegistered) &&
            widget.eventData.details.hasFormData == 3 &&
            !isPreview)
        ? const SizedBox()
        : (!isPreview &&
                (((widget.eventData.formData!.endDate
                            .compareTo(DateTime.now())) <
                        0) ||
                    ((widget.eventData.formData!.startDate
                            .compareTo(DateTime.now())) >
                        0)) &&
                (status == EventStatus.notRegistered))
            ? const SizedBox()
            : Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: isPreview || !(status == EventStatus.notRegistered)
                      ? containerColor
                      : (widget.eventData.details.hasFormData == 3)
                          ? Colors.transparent
                          : ((((widget.eventData.formData!.endDate
                                          .compareTo(DateTime.now())) <
                                      0) ||
                                  ((widget.eventData.formData!.startDate
                                          .compareTo(DateTime.now())) >
                                      0)))
                              ? Colors.transparent
                              : containerColor,
                ),
                height: 73,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isPreview) ...[
                      CustomButton(
                        onTap: () async {
                          if (isProcessing) {
                            return;
                          }
                          setState(() {
                            isProcessing = true;
                          });
                          final res = await _addEvent(widget.eventData);
                          if (res != '') {
                            showErrorMessage(context, res);
                            setState(() {
                              isProcessing = false;
                            });
                          } else {
                            showSuccessMessage(context, 'Event Added');
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.data!.name == 'ManageEventsRoute');
                          }
                        },
                        text: 'Add Event',
                        isProcessing: isProcessing,
                      ),
                    ] else if (widget.eventData.registrationType == 9) ...[
                      CustomButton(
                        // width: 200,
                        onTap: () async {
                          openUrl(widget.eventData.details.link!.first);
                        },
                        text: 'Register Now',
                        isProcessing: isProcessing,
                      ),
                    ] else if (!(status == EventStatus.notRegistered) ||
                        (!(widget.eventData.details.hasFormData == 3) &&
                            !(((widget.eventData.formData!.endDate
                                            .compareTo(DateTime.now()) <
                                        0) ||
                                    (widget.eventData.formData!.startDate
                                            .compareTo(DateTime.now()) >
                                        0)) &&
                                status == EventStatus.notRegistered)))
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (status == EventStatus.notRegistered)
                                if (widget.eventData.registrationType == 1 ||
                                    (widget.eventData.registrationType == 2 &&
                                        isThaparId) ||
                                    (widget.eventData.registrationType == 5 &&
                                        isThaparId) ||
                                    (widget.eventData.registrationType == 7 &&
                                        isThaparId) ||
                                    (widget.eventData.registrationType == 6) ||
                                    (widget.eventData.registrationType ==
                                        8)) ...[
                                  CustomButton(
                                    // width: 150,
                                    onTap: () async {
                                      if (!isProcessing) {
                                        if (status ==
                                            EventStatus.notRegistered) {
                                          setState(() {
                                            isProcessing = true;
                                          });
                                          final res = await ref
                                              .read(eventPageProvider.notifier)
                                              .registerForEvents();
                                          if (res != '') {
                                            showErrorMessage(context, res);
                                          } else {
                                            context.navigateTo(
                                                const SucessRoute());
                                          }
                                          setState(() {
                                            isProcessing = false;
                                          });
                                        } else if (status !=
                                                EventStatus.loading ||
                                            status != EventStatus.initial ||
                                            status != EventStatus.error) {
                                          context.navigateTo(TicketRoute(
                                              eventData: widget.eventData,
                                              eventUserData: eventUserData!));
                                        }
                                      }
                                    },
                                    text: status == EventStatus.notRegistered
                                        ? 'Get Ticket'
                                        : 'View Ticket',
                                    isProcessing: isProcessing,
                                  ),
                                ],
                              if (!(status == EventStatus.notRegistered) ||
                                  (widget.eventData.registrationType == 3 ||
                                      (widget.eventData.registrationType ==
                                          4) ||
                                      (widget.eventData.registrationType ==
                                          5) ||
                                      (widget.eventData.registrationType == 6)))
                                CustomButton(
                                  // width: 0,
                                  onTap: () async {
                                    if (!isProcessing) {
                                      if (status == EventStatus.notRegistered) {
                                        context.navigateTo(
                                          FormRoute(
                                            registrationProcess: widget
                                                .eventData
                                                .details
                                                .registrationProcess
                                                .trim(),
                                            rulesAndRegulation: widget.eventData
                                                .details.rulesAndRegulation
                                                .trim(),
                                            data: widget.eventData.formData!,
                                            eventId: widget
                                                .eventData.details.eventId,
                                            eventName:
                                                widget.eventData.details.title,
                                          ),
                                        );
                                      } else if (status !=
                                              EventStatus.loading ||
                                          status != EventStatus.initial ||
                                          status != EventStatus.error) {
                                        context.navigateTo(TicketRoute(
                                            eventData: widget.eventData,
                                            eventUserData: eventUserData!));
                                      }
                                    }
                                  },
                                  text: status == EventStatus.notRegistered
                                      ? 'Register'
                                      : 'View Ticket',
                                  isProcessing: isProcessing,
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
  }

  Future<String> _addEvent(EventDetails data) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    if (!await hasInternetAccess()) {
      return 'No Internet Connection';
    }
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      FirebaseFirestore.instance
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(data.details.eventId)
          .set(
            data.toJson(),
          )
          .onError(
            (error, stackTrace) => showErrorMessage(
              context,
              error.toString(),
            ),
          );
    } catch (e) {
      return e.toString();
    }

    return '';
  }
}
