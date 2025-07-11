import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';

import 'package:Saturnalia/src/ui/home/home_page_model.dart';
import 'package:Saturnalia/src/utils/name_utils.dart';

import '../../widgets/event_card.dart';

class AllEventsSection extends ConsumerWidget {
  const AllEventsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = ref.watch(
      homePageProvider.select((_) => _.tag),
    );
    final eventList = ref
        .watch(eventsPageProvider.select(
          (_) => _.allPublicEvents,
        ))
        ?.where((element) => !element.isInformal)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Events'.toUpperCase(),
                style: GoogleFonts.rocknRollOne(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (eventList != null) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'all',
                'music',
                'dance',
                'tech',
                'cultural',
                'business',
                'art',
                'games',
                'videography',
                'literature',
                'drama',
                'photography',
                'generalknowledge',
                'fashion',
                'design',
                'computer',
                'electrical',
                'electronics',
                'mechanical',
                'civil',
              ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _FilterBox(
                        tag: e.capitalize(),
                        isSelected: tag.split('-').contains(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 175,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => EventCard(
                isVisible: tag == 'all'
                    ? true
                    : eventList[index].details.tag.toLowerCase().contains(tag),
                data: eventList[index],
              ),
              itemCount: eventList.length,
              shrinkWrap: true,
            ),
          ),
        ] else ...[
          const SizedBox(
            height: 190,
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          )
        ]
      ],
    );
  }
}

class _FilterBox extends ConsumerWidget {
  final String tag;
  final bool isSelected;
  const _FilterBox({
    super.key,
    required this.tag,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(homePageProvider.notifier).setFilterTag(tag.toLowerCase());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1,
              color:
                  isSelected ? secondaryColor : Colors.white.withOpacity(0.5)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Text(
              tag,
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? secondaryColor : Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
