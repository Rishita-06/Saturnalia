import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class CustomDropDownButton<ItemType> extends ConsumerStatefulWidget {
  final ItemType? selectedId;
  final bool isEnabled;
  final String label;
  final String? initialText;

  final Function(dynamic value) onChanged;
  final Color? backgroundColor;
  final List<ItemType> data;
  const CustomDropDownButton({
    super.key,
    required this.selectedId,
    required this.onChanged,
    required this.data,
    this.backgroundColor = scaffoldColor,
    this.initialText,
    required this.label,
    this.isEnabled = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VenueDropDownButtonState<ItemType>();
}

class _VenueDropDownButtonState<ItemType>
    extends ConsumerState<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                )
              ],
            ),
            child: Center(
              child: DropdownButton<ItemType>(
                onChanged: widget.onChanged,
                isExpanded: true,
                isDense: true,
                itemHeight: 50,
                value: widget.selectedId,
                hint: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    widget.data.isEmpty ? '' : widget.initialText ?? '',
                    style: GoogleFonts.rocknRollOne(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                underline: const SizedBox(),
                iconEnabledColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                dropdownColor: containerColor,
                items: widget.data
                    .map(
                      (e) => DropdownMenuItem<ItemType>(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            e.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
