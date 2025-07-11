import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class EventTextField extends ConsumerStatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String initialText;
  final bool isDigitOnly;
  final bool? isEnabled;
  final int? maxlines;
  final Color? backgroundColor;
  final int? maxLength;
  final Function(String value) onChanged;
  const EventTextField({
    super.key,
    required this.hintText,
    required this.label,
    this.isEnabled = true,
    required this.onChanged,
    required this.initialText,
    this.backgroundColor = containerColor,
    this.isDigitOnly = false,
    required this.maxLength,
    this.controller,
    this.maxlines = 1,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<EventTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != '')
          Text(
            widget.label,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            maxLines: widget.maxlines,
            enabled: widget.isEnabled,
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            controller: widget.controller,
            scrollPadding: const EdgeInsets.only(bottom: 130),
            keyboardType: widget.isDigitOnly
                ? const TextInputType.numberWithOptions(decimal: false)
                : null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: widget.backgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: widget.backgroundColor ?? containerColor,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            inputFormatters: widget.isDigitOnly
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: widget.isEnabled ?? true
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
