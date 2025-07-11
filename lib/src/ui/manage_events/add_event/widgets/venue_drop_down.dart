import 'package:Saturnalia/src/ui/manage_events/add_event/widgets/show_add_new_venue_botton_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class VenueDropDownButton<ItemType> extends ConsumerStatefulWidget {
  final ItemType? selectedId;
  final bool isEnabled;
  final String? initialText;

  final Function(dynamic value) onChanged;
  final Color? backgroundColor;
  final List<Map<ItemType, dynamic>> data;
  const VenueDropDownButton({
    super.key,
    required this.selectedId,
    required this.onChanged,
    required this.data,
    this.backgroundColor = scaffoldColor,
    this.initialText,
    this.isEnabled = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VenueDropDownButtonState<ItemType>();
}

class _VenueDropDownButtonState<ItemType>
    extends ConsumerState<VenueDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff181818),
              borderRadius: BorderRadius.circular(10),
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
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                underline: const SizedBox(),
                iconEnabledColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                dropdownColor: const Color(0xff181818),
                items: widget.data
                    .map(
                      (e) => DropdownMenuItem<ItemType>(
                        value: e.keys.first,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            e.values.first,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
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
        const SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: () {
              showAddNewvenueBottomSheet(context);
            },
            child: Container(
              height: 50,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add New',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
