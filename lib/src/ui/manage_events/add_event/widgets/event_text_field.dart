import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../add_event_model.dart';

class EventTextField extends ConsumerWidget {
  final String label;
  final String hintText;
  final String initialText;
  final bool isDigitOnly;
  final int? maxLength;
  final Function(String value) onChanged;
  const EventTextField({
    super.key,
    required this.hintText,
    required this.label,
    required this.onChanged,
    required this.initialText,
    this.isDigitOnly = false,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rocknRollOne(
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
          child: TextField(
            controller: TextEditingController(text: initialText),
            onChanged: onChanged,
            maxLength: maxLength,
            keyboardType: isDigitOnly
                ? const TextInputType.numberWithOptions(decimal: false)
                : null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: secondaryColor.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            inputFormatters: isDigitOnly
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionTextField extends ConsumerWidget {
  final String initialText;
  const DescriptionTextField({
    super.key,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
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
          child: TextField(
            controller: TextEditingController(
              text: initialText,
            ),
            onChanged: (value) {
              ref.read(addEventModelProvider.notifier).setDescription(value);
            },
            maxLines: null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: 'Description',
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class PointTextField extends ConsumerWidget {
  final String initialText;
  const PointTextField({
    super.key,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Point Of Contact',
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
          child: TextField(
            controller: TextEditingController(
              text: initialText,
            ),
            onChanged: (value) {
              ref.read(addEventModelProvider.notifier).setPointOfContact(value);
            },
            maxLines: null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: 'Point Of Contact',
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class RulesTextField extends ConsumerWidget {
  final String initialText;
  const RulesTextField({
    super.key,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rules and Regulations',
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
          child: TextField(
            controller: TextEditingController(
              text: initialText,
            ),
            onChanged: (value) {
              ref.read(addEventModelProvider.notifier).setRules(value);
            },
            maxLines: null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: 'Rules and Regulations',
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class TermsTextField extends ConsumerWidget {
  final String initialText;
  const TermsTextField({
    super.key,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions',
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
          child: TextField(
            controller: TextEditingController(
              text: initialText,
            ),
            onChanged: (value) {
              ref.read(addEventModelProvider.notifier).setTerms(value);
            },
            maxLines: null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: 'Terms and Conditions',
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class RegistrtationTextField extends ConsumerWidget {
  final String initialText;
  const RegistrtationTextField({
    super.key,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Registration Process',
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
          child: TextField(
            controller: TextEditingController(
              text: initialText,
            ),
            onChanged: (value) {
              ref.read(addEventModelProvider.notifier).setRegistration(value);
            },
            maxLines: null,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: const Color(0xff181818),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              hintText: 'Registration Process',
              hintStyle: GoogleFonts.outfit(
                fontSize: 13,
                color: primaryColor.withOpacity(0.5),
              ),
            ),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
