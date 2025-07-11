import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';

import '../../widgets/event_info_card.dart';

showEventBottomSheet(BuildContext context, String type) {
  return showSaturnaliaBottomSheet(
    context: context,
    builder: (context) => EventsBottomSheet(
      type: type,
      mainContext: context,
    ),
  );
}

class EventsBottomSheet extends ConsumerStatefulWidget {
  final String type;
  final BuildContext mainContext;
  const EventsBottomSheet({
    super.key,
    required this.mainContext,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventsBottomSheetState();
}

class _EventsBottomSheetState extends ConsumerState<EventsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final eventList = ref.watch(
      eventsPageProvider.select((_) => _.allPublicEvents),
    );
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: const BoxConstraints(maxHeight: 450),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.type == 'edit'
                      ? 'Select Event To Edit'
                      : 'Select Event',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: eventList?.length ?? 0,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EventInfoCard(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (widget.type == 'edit') {
                      widget.mainContext.navigateTo(AddEventRoute(
                        eventData: eventList[index],
                      ));
                    } else {
                      widget.mainContext.navigateTo(QRScannnerRoute(
                        eventId: eventList[index].details.eventId,
                        eventName: eventList[index].details.title,
                      ));
                    }
                  },
                  data: eventList![index],
                  isVisible: true,
                ),
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
