import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/models/event_details.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';
import 'package:Saturnalia/src/utils/web_utils.dart';

class InfoSection extends ConsumerStatefulWidget {
  final EventDetails data;

  const InfoSection({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoSectionState();
}

class _InfoSectionState extends ConsumerState<InfoSection> {
  bool showScrollHint = false;
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(Duration.zero, () {
      if ((_scrollController?.position.maxScrollExtent ?? 0) > 0.0) {
        setState(() {
          showScrollHint = true;
        });
      }
      _scrollController?.addListener(() {
        if ((_scrollController?.position.pixels.floor() ?? 0) >=
            (_scrollController?.position.maxScrollExtent.floor() ?? 0)) {
          setState(() {
            showScrollHint = false;
          });
        } else {
          setState(() {
            showScrollHint = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        ScrollConfiguration(
          behavior: NoOverscrollScrollBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_sharp,
                      color: Colors.white.withOpacity(0.6),
                      size: 17,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${prettyTimeStamp2(widget.data.details.eventDate)} ${widget.data.details.eventEndDate != null && prettyTimeStamp2(widget.data.details.eventDate) != prettyTimeStamp2(widget.data.details.eventEndDate) ? '-${prettyTimeStamp2(widget.data.details.eventEndDate)}' : ''}',
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white.withOpacity(0.6),
                      size: 17,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${prettyTimeStamp4(widget.data.details.eventDate)} ${widget.data.details.eventEndDate != null ? '-${prettyTimeStamp4(widget.data.details.eventEndDate)}' : 'Onwards'}',
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white.withOpacity(0.6),
                      size: 17,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.data.details.venue,
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'About',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data.details.description,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.50),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.data.details.link != null)
                  if (widget.data.details.link!.isNotEmpty) ...[
                    Text(
                      'Links',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.data.details.link!
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                  onTap: () {
                                    openUrl(e);
                                  },
                                  child: Text(
                                    e.trim(),
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        if (showScrollHint)
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 50,
              child: Align(
                alignment: Alignment.center,
                child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    child: Lottie.asset('assets/lottie/arrow_down.json',
                        height: 50)),
              ),
            ),
          ),
      ],
    );
  }
}
