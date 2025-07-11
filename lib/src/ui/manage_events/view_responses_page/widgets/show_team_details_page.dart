import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/models/event_user_data.dart';

import 'package:Saturnalia/src/ui/manage_events/view_responses_page/view_responses_model.dart';
import 'package:Saturnalia/src/ui/manage_events/view_responses_page/widgets/response_card.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

showTeamDetailsBottomSheet(
  BuildContext context,
  EventUserData data, {
  bool isEditing = true,
}) {
  return showSaturnaliaBottomSheet(
      context: context,
      builder: (context) => ShowTeamDetails(
            data: data,
            isEditing: isEditing,
          ));
}

class ShowTeamDetails extends ConsumerStatefulWidget {
  final EventUserData data;
  final bool isEditing;
  const ShowTeamDetails({
    super.key,
    required this.data,
    required this.isEditing,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowTeamDetailsState();
}

class _ShowTeamDetailsState extends ConsumerState<ShowTeamDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500),
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ScrollConfiguration(
          behavior: NoOverscrollScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text('Team Leader'),
                const SizedBox(
                  height: 10,
                ),
                ResponseCard(
                  data: widget.data,
                  isEditing: widget.isEditing,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.data.formResponse != null &&
                    widget.data.formResponse!.isNotEmpty) ...[
                  const Text('Form Response'),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: widget.data.formResponse!
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      e.title,
                                      style: GoogleFonts.outfit(
                                        // color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      e.value,
                                      style: GoogleFonts.outfit(
                                        // color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
                const SizedBox(
                  height: 15,
                ),
                if (widget.data.teamDetails != null &&
                    widget.data.teamDetails!.isNotEmpty) ...[
                  const Text('Team Members'),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.data.teamDetails?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ref.read(viewResponsesPageProvider.select(
                                  (value) => value.data?.firstWhere(
                                    (element) =>
                                        element.userId ==
                                        widget.data.teamDetails?[index].userId,
                                  ),
                                )) ==
                                null
                            ? const SizedBox()
                            : ResponseCard(
                                teamMember: index + 2,
                                data: ref.read(
                                  viewResponsesPageProvider.select(
                                    (value) => value.data!.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            widget.data.teamDetails![index]
                                                .userId),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
