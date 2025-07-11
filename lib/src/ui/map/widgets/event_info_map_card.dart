import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/models/event_details.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../../constants/colors.dart';

class EventInfoMapCard extends ConsumerStatefulWidget {
  final EventDetails data;
  final bool isVisible;
  final VoidCallback onTap;
  const EventInfoMapCard({
    super.key,
    required this.data,
    required this.isVisible,
    required this.onTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventInfoMapCardState();
}

class _EventInfoMapCardState extends ConsumerState<EventInfoMapCard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return !widget.isVisible
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 5,
              ),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondaryColor,
                  ),
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      prettyTimeStamp9(
                                              widget.data.details.eventDate)
                                          .toString()
                                          .replaceAll('|', '\n'),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.data.details.title.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.rocknRollOne(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
