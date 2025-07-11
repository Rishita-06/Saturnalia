import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/ui/widgets/back_button.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import 'package:string_similarity/string_similarity.dart';

import '../../constants/colors.dart';
import '../../logic/repositories/events_repository/events_respository.dart';
import '../../routing/router.dart';
import '../widgets/custom_text.dart';
import '../widgets/event_box.dart';

@RoutePage()
class QrEventListPage extends ConsumerStatefulWidget {
  final bool isSearching;
  const QrEventListPage({
    super.key,
    required this.isSearching,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QrEventListPageState();
}

class _QrEventListPageState extends ConsumerState<QrEventListPage> {
  String search = '';
  List<EventDetails> eventData = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final eventList = ref
          .read(eventsPageProvider.select((value) => value.allPublicEvents!));
      eventData = eventList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(
                  width: 10,
                ),
                CustomText2(
                  widget.isSearching ? 'Search Event' : 'Choose Event',
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) {
                  List<EventDetails> bestMatch = [];
                  double bestScore = 0.2;
                  final eventDetails = ref.read(eventsPageProvider
                      .select((value) => value.allPublicEvents!));
                  if (value.trim().isEmpty || value.trim().length <= 3) {
                    eventData = eventDetails;
                    setState(() {});
                    return;
                  }
                  for (var question in eventDetails) {
                    final similarity = value
                        .trim()
                        .toLowerCase()
                        .similarityTo(question.details.title.toLowerCase());
                    if (similarity > bestScore) {
                      bestScore = similarity;
                      bestMatch.add(question);
                    }
                  }
                  eventData = bestMatch;
                  setState(() {});
                },
                cursorColor: secondaryColor,
                scrollPadding: const EdgeInsets.only(bottom: 130),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: secondaryColor,
                      width: 1.5,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: null,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoOverscrollScrollBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AllEventBox(
                      onTap: () {
                        if (widget.isSearching) {
                          context
                              .navigateTo(EventRoute(data: eventData[index]));
                        } else {
                          context.navigateTo(
                            QRScannnerRoute(
                                eventId: eventData[index].details.eventId,
                                eventName: eventData[index].details.title),
                          );
                        }
                      },
                      eventData: eventData[index],
                    ),
                  ),
                ),
                itemCount: eventData.length,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
