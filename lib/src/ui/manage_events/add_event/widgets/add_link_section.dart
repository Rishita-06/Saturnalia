import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/ui/manage_events/add_event/add_event_model.dart';
import 'package:Saturnalia/src/ui/manage_events/event_form_page/widgets/event_text_field.dart';

import '../../../../constants/colors.dart';

class AddLinkSection extends ConsumerStatefulWidget {
  const AddLinkSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddLinkSectionState();
}

class _AddLinkSectionState extends ConsumerState<AddLinkSection> {
  @override
  Widget build(BuildContext context) {
    final link = ref.watch(addEventModelProvider.select((value) => value.link));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: link.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: LinkEventField(
                key: ValueKey(link.length),
                link: link[index],
                index: index,
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                ref.read(addEventModelProvider.notifier).addLink();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                    )
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Add Link',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LinkEventField extends ConsumerStatefulWidget {
  final String link;
  final int index;
  const LinkEventField({
    super.key,
    required this.link,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkEventFieldState();
}

class _LinkEventFieldState extends ConsumerState<LinkEventField> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: EventTextField(
            controller: controller,
            hintText: 'https://saturnalia23.com/',
            label: 'Link ${widget.index + 1}',
            onChanged: (value) {
              ref
                  .read(addEventModelProvider.notifier)
                  .setLink(widget.index, value);
            },
            initialText: widget.link,
            maxLength: null,
          ),
        ),
        GestureDetector(
          onTap: () {
            ref.read(addEventModelProvider.notifier).removeLink(widget.index);
          },
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
