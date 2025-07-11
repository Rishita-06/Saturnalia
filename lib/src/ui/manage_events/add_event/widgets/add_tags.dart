import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/colors.dart';

import '../add_event_model.dart';

class AddTags extends ConsumerStatefulWidget {
  const AddTags({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTagsState();
}

class _AddTagsState extends ConsumerState<AddTags> {
  @override
  Widget build(BuildContext context) {
    final tags = [
      'music',
      'dance',
      'tech',
      'cultural',
      'business',
      'art',
      'videography','games',
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
    ];
    final selectedTags = ref.watch(
      addEventModelProvider.select((_) => _.tags),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          runSpacing: 10,
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: tags
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (selectedTags.contains(e)) {
                      ref.read(addEventModelProvider.notifier).removeTags(e);
                    } else {
                      ref.read(addEventModelProvider.notifier).setTags(e);
                    }
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff181818),
                        borderRadius: BorderRadius.circular(10),
                        border: selectedTags.contains(e)
                            ? Border.all(
                                width: 1,
                                color: primaryColor,
                              )
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          e,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
