import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class CustomSatDropDownButton<ItemType> extends ConsumerStatefulWidget {
  final ItemType? selectedId;
  final bool isEnabled;
  final double width;

  final String? initialText;

  final Function(dynamic value) onChanged;
  final Color? backgroundColor;
  final List<Map<ItemType, String>> data;
  const CustomSatDropDownButton({
    super.key,
    required this.selectedId,
    required this.onChanged,
    required this.data,
    this.backgroundColor = scaffoldColor,
    this.initialText,
    this.width = 150,
    this.isEnabled = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSatDropDownButtonState<ItemType>();
}

class _CustomSatDropDownButtonState<ItemType>
    extends ConsumerState<CustomSatDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 45,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white.withOpacity(0.2),
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
                dropdownColor: widget.backgroundColor ??
                    const Color.fromARGB(255, 63, 61, 61),
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
      ],
    );
  }
}
