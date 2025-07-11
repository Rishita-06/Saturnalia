import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final String label;
  final String hintText;
  final String initialText;
  final String hint;
  final bool isShowMaxLength;
  final bool isDigitOnly;
  final bool? isEnabled;
  final int? maxlines;
  final Color? backgroundColor;
  final int? maxLength;
  final Function(String value) onChanged;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.label,
    this.isEnabled = true,
    this.hint = '',
    required this.onChanged,
    required this.initialText,
    this.isShowMaxLength = false,
    this.backgroundColor = containerColor,
    this.isDigitOnly = false,
    required this.maxLength,
    this.maxlines = 1,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  Widget counter(
    BuildContext context, {
    required int currentLength,
    required int? maxLength,
    required bool isFocused,
  }) {
    return Text(
      '$currentLength/$maxLength',
      semanticsLabel: 'character count',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != '')
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (widget.hint.trim().isNotEmpty) ...[
                const SizedBox(
                  width: 10,
                ),
                Tooltip(
                  message: widget.hint,
                  triggerMode: TooltipTriggerMode.tap,
                  child: const Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ]
            ],
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
            buildCounter: counter,
            controller: TextEditingController(text: widget.initialText),
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            cursorColor: secondaryColor,
            scrollPadding: const EdgeInsets.only(bottom: 130),
            keyboardType: widget.isDigitOnly
                ? const TextInputType.numberWithOptions(decimal: false)
                : null,
            decoration: InputDecoration(
              counterText: widget.isShowMaxLength ? null : '',
              counterStyle: GoogleFonts.outfit(
                fontSize: 14,
                color: widget.isEnabled ?? true
                    ? secondaryColor
                    : secondaryColor.withOpacity(0.5),
              ),
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
              hintText: widget.hintText,
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            inputFormatters: widget.isDigitOnly
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            style: GoogleFonts.lato(
              fontSize: 15,
              color: widget.isEnabled ?? true
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              fontWeight: (widget.isEnabled ?? true) ? null : FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
