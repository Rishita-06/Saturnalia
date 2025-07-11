// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:Saturnalia/src/models/poll_data.dart';
import 'package:Saturnalia/src/ui/poll/poll_page_model.dart';
import 'package:Saturnalia/src/ui/widgets/delete_confirmation_popup.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/try_again_widget.dart';

@RoutePage()
class PollPage extends ConsumerStatefulWidget {
  final bool isEditing;
  const PollPage({
    super.key,
    required this.isEditing,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PollPageState();
}

class _PollPageState extends ConsumerState<PollPage> {
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(pollPageProvider.select((value) => value.status));
    final polls = ref.watch(pollPageProvider.select((value) => value.polls));
    return SafeArea(
        child: Scaffold(
      body: status == PollPageStatus.loaded && polls != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ScrollConfiguration(
                behavior: NoOverscrollScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Polls',
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        key: const ValueKey(1),
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: polls
                            .map(
                              (e) => e.isPublic || widget.isEditing
                                  ? PollCard(
                                      key: ValueKey(e),
                                      isEditing: widget.isEditing,
                                      data: e,
                                    )
                                  : const SizedBox(),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : TryAgainWidget(
              onTap: () {
                ref.read(pollPageProvider.notifier).init();
              },
              noInternet: status == PollPageStatus.noInternet,
              isProcessing: status == PollPageStatus.initial ||
                  status == PollPageStatus.loading,
            ),
    ));
  }
}

class PollCard extends ConsumerStatefulWidget {
  final PollData data;
  final bool isEditing;
  const PollCard({
    super.key,
    required this.data,
    required this.isEditing,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __PollCardState();
}

class __PollCardState extends ConsumerState<PollCard> {
  bool alreadyVoted = true;
  String isSelected = '';
  bool isProcssing = false;
  StreamSubscription? _subscription;
  List<int>? count;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      count = List.generate(widget.data.options.length, (index) => 0);
      if (mounted) {
        setState(() {});
      }
      final userData = ref.read(
        appRepositoryProvider.select((_) => _.userData?.userId),
      );

      if (true) {
        if (mounted) {
          _subscription = ref
              .read(firebaseFirestoreProvider)
              .collection('polls')
              .doc(widget.data.id)
              .collection('users')
              .snapshots()
              .listen((event) async {
            if (event.docs.isNotEmpty) {
              if (event.docs
                  .where((element) => element.id == userData)
                  .isNotEmpty) {
                if (mounted) {
                  setState(() {
                    alreadyVoted = true;
                    isSelected = event.docs
                        .where((element) => element.id == userData)
                        .first
                        .data()['option'];
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    alreadyVoted = false;
                  });
                }
              }
              for (int i = 0; i < widget.data.options.length; i++) {
                if (mounted) {
                  final counts = await ref
                      .read(firebaseFirestoreProvider)
                      .collection('polls')
                      .doc(widget.data.id)
                      .collection('users')
                      .where('option', isEqualTo: widget.data.options[i])
                      .get();

                  count![i] = counts.size;
                }
              }
              setState(() {});
            } else {
              if (mounted) {
                setState(() {
                  alreadyVoted = false;
                });
              }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryContainerColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.data.title,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.data.subTitle.trim().isNotEmpty) ...[
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.data.subTitle,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.data.options.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: count == null
                                      ? 0
                                      : MediaQuery.sizeOf(context).width *
                                          ((count![index] /
                                              (getTotalCount(count) == 0
                                                  ? 1
                                                  : getTotalCount(count)))),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.primaries[Random().nextInt(
                                            Colors.primaries.reversed.length)]
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!alreadyVoted) {
                                      setState(() {
                                        isSelected = widget.data.options[index];
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected ==
                                              widget.data.options[index]
                                          ? secondaryColor.withOpacity(0.2)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected ==
                                                widget.data.options[index]
                                            ? secondaryColor
                                            : primaryColor,
                                        width: isSelected ==
                                                widget.data.options[index]
                                            ? 2
                                            : 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${index + 1}.',
                                            style: GoogleFonts.lato(
                                              fontSize: 16,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.data.options[index],
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          if (count != null) ...[
                                            Text(
                                              '${count![index]}',
                                              style: GoogleFonts.lato(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '${((count![index] / (getTotalCount(count) == 0 ? 1 : getTotalCount(count))) * 100).toStringAsFixed(0)}%',
                                              style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: widget.data.pollEndTime
                                        .compareTo(DateTime.now()) >
                                    0
                                ? TweenAnimationBuilder<Duration>(
                                    duration: prettyTimeStamp3(
                                        widget.data.pollEndTime),
                                    tween: Tween(
                                        begin: prettyTimeStamp3(
                                            widget.data.pollEndTime),
                                        end: Duration.zero),
                                    onEnd: () async {
                                      // ref
                                      //     .read(contactUsPageProvider
                                      //         .notifier)
                                      //     .init();
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      if (mounted) {
                                        setState(() {
                                          isSelected = '';
                                        });
                                      }
                                    },
                                    builder: (BuildContext context,
                                        Duration value, Widget? child) {
                                      final hours = (value.inHours % 24) < 10
                                          ? '0${(value.inHours % 24)}'
                                          : (value.inHours % 24);
                                      final minutes =
                                          (value.inMinutes % 60) < 10
                                              ? '0${(value.inMinutes % 60)}'
                                              : (value.inMinutes % 60);
                                      final seconds =
                                          (value.inSeconds % 60) < 10
                                              ? '0${(value.inSeconds % 60)}'
                                              : (value.inSeconds % 60);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ends in',
                                            style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.white.withOpacity(0.6),
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
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Poll Ended On',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                      Text(
                                        prettyTimeStamp9(
                                            widget.data.pollEndTime),
                                      ),
                                    ],
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (!alreadyVoted && !isProcssing) {
                                      if (widget.data.pollEndTime
                                              .compareTo(DateTime.now()) <
                                          0) {
                                        return;
                                      }

                                      if (isSelected.trim().isEmpty) {
                                        showErrorMessage(context,
                                            'Please select an otpion first');
                                      } else {
                                        showDeleteConfirmationPopup(context,
                                            title:
                                                'Are you sure you want to vote to this option?',
                                            onCancel: () {
                                              context.maybePop();
                                            },
                                            isProcessing: false,
                                            onConfirm: () async {
                                              final res = await ref
                                                  .read(
                                                      pollPageProvider.notifier)
                                                  .addVote(
                                                      widget.data.id,
                                                      isSelected,
                                                      widget.data.coins);
                                              if (res != '') {
                                                showErrorMessage(context, res);
                                              } else {
                                                showSuccessMessage(context,
                                                    'Voted Sucessfully!');
                                              }
                                              context.maybePop();
                                            });
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: alreadyVoted
                                          ? Colors.green
                                          : widget.data.pollEndTime.compareTo(
                                                      DateTime.now()) >
                                                  0
                                              ? primaryColor
                                              : Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        alreadyVoted
                                            ? 'Voted'
                                            : widget.data.pollEndTime.compareTo(
                                                        DateTime.now()) >
                                                    0
                                                ? "Vote"
                                                : 'Ended',
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Total Votes : ${getTotalCount(count)}',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getTotalCount(List<int>? count) {
    int total = 0;
    if (count == null) {
      return total;
    }
    for (int counts in count) {
      total += counts;
    }
    return total;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
