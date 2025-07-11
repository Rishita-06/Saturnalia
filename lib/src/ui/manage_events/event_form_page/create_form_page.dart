import 'package:Saturnalia/src/models/form_data.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saturnalia/src/constants/strings.dart';
import 'package:Saturnalia/src/models/dynamic_form_data.dart';
import 'package:Saturnalia/src/routing/router.dart';
import 'create_form_page_model.dart';

import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../../../constants/colors.dart';
import '../../widgets/custom_sat_drop_down.dart';
import 'widgets/event_text_field.dart';

@RoutePage()
class CreateFormPage extends ConsumerStatefulWidget {
  final List<DyamicFormData>? data;
  final int maxSize;
  final int minSize;
  const CreateFormPage({
    super.key,
    this.data,
    required this.minSize,
    required this.maxSize,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends ConsumerState<CreateFormPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.data != null) {
        ref.read(createFormPageProvider.notifier).init(widget.data!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formList =
        ref.watch(createFormPageProvider.select((value) => value.formList));
    // print(formList[0].id);
    // print(formList[1].id);

    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'create',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: ' Form',
                          style: GoogleFonts.outfit(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ScrollConfiguration(
                    behavior: NoOverscrollScrollBehavior(),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: formList.length,
                      itemBuilder: (context, index) => Column(
                        key: ValueKey(formList.length),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _DynamicFormData(
                              index: index,
                            ),
                          ),
                          const Divider(
                            color: primaryColor,
                            thickness: 1.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(createFormPageProvider.notifier).addField();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryContainerColor,
                    ),
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        'Add a field',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final res = ref
                        .read(createFormPageProvider.notifier)
                        .validateForm();
                    if (res != '') {
                      showErrorMessage(context, res);
                      return;
                    }

                    context.navigateTo(
                      FormRoute(
                          data: FormData(
                            data: formList,
                            endDate: DateTime.now(),
                            startDate: DateTime.now(),
                            teamMinSize: widget.minSize,
                            teamMaxSize: widget.maxSize,
                          ),
                          isPreview: true),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: formList.isEmpty ? secondaryColor : primaryColor,
                    ),
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        'Preview',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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

class _DynamicFormData extends ConsumerStatefulWidget {
  final int index;
  const _DynamicFormData({
    super.key,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DynamicFormDataState();
}

class __DynamicFormDataState extends ConsumerState<_DynamicFormData> {
  TextEditingController? _titleController;
  TextEditingController? _lengthController;
  // TextEditingController? _linesController;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final formList =
          ref.read(createFormPageProvider.select((value) => value.formList));
      _titleController =
          TextEditingController(text: formList[widget.index].data.title);
      _lengthController = TextEditingController(
          text: (formList[widget.index].data.maxLength ?? '').toString());
      // _linesController = TextEditingController(
      //     text: (formList[widget.index].data.maxLines ?? '1').toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final formList =
        ref.watch(createFormPageProvider.select((value) => value.formList));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Field ${widget.index + 1}',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                ref
                    .read(createFormPageProvider.notifier)
                    .removeField(widget.index);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Title ${widget.index + 1}',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: EventTextField(
                      controller: _titleController,
                      key: ValueKey(formList.length),
                      hintText: 'Enter title',
                      label: '',
                      onChanged: (value) {
                        ref
                            .read(createFormPageProvider.notifier)
                            .setFieldTitle(widget.index, value);
                      },
                      initialText: '',
                      maxLength: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Field Type',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (formList[widget.index].type == 0 ||
                            formList[widget.index].type == 1)
                          Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: formList[widget.index].type == 0
                                ? 'Max 99 characters allowed'
                                : formList[widget.index].type == 1
                                    ? 'Max 9999 characters allowed'
                                    : '',
                            child: const Icon(
                              Icons.help,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomSatDropDownButton<int>(
                      backgroundColor: containerColor,
                      selectedId: formList[widget.index].type,
                      width: 200,
                      onChanged: (value) {
                        ref
                            .read(createFormPageProvider.notifier)
                            .setFieldType(widget.index, value);
                      },
                      initialText: 'Select Field Type',
                      data: formTypes,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (formList[widget.index].type == 1) ...[
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Max char',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: EventTextField(
                        controller: _lengthController,
                        hintText: 'Enter max length(in characters)',
                        label: '',
                        isDigitOnly: true,
                        onChanged: (value) {
                          ref
                              .read(createFormPageProvider.notifier)
                              .setFieldMaxLength(
                                  widget.index,
                                  int.parse(
                                      value.trim().isEmpty ? '0' : value));
                        },
                        initialText: '0',
                        maxLength: 4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              const SizedBox(
                height: 10,
              ),

              // if (formList[widget.index].type <= 3) ...[
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: Text(
              //         'Max Lines',
              //         style: GoogleFonts.outfit(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 4,
              //       child: EventTextField(
              //         controller: _linesController,
              //         hintText: 'Enter max lines(no of rows)',
              //         label: '',
              //         isDigitOnly: true,
              //         onChanged: (value) {
              //           ref
              //               .read(createFormPageProvider.notifier)
              //               .setFieldMaxLines(
              //                   widget.index,
              //                   int.parse(
              //                       value.trim().isEmpty ? '0' : value));
              //         },
              //         initialText: '1',
              //         maxLength: 2,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // ],
              if (formList[widget.index].type == 4) ...[
                ListView.builder(
                  shrinkWrap: true,
                  key: ValueKey(
                      formList[widget.index].data.options?.length ?? 0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: formList[widget.index].data.options?.length,
                  itemBuilder: (context, index) => _OptionsField(
                      fieldIndex: widget.index, optionIndex: index),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(createFormPageProvider.notifier)
                            .addOptions(widget.index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                                Text(
                                  'Add Option',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionsField extends ConsumerStatefulWidget {
  final int fieldIndex;
  final int optionIndex;
  const _OptionsField({
    super.key,
    required this.fieldIndex,
    required this.optionIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __OptionsFieldState();
}

class __OptionsFieldState extends ConsumerState<_OptionsField> {
  TextEditingController? _optionController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final formList =
          ref.read(createFormPageProvider.select((value) => value.formList));
      _optionController = TextEditingController(
          text: formList[widget.fieldIndex]
              .data
              .options![widget.optionIndex]
              .optionValue);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final formList =
        ref.watch(createFormPageProvider.select((value) => value.formList));
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Option ${widget.optionIndex + 1}',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: EventTextField(
            controller: _optionController,
            hintText: 'Enter option title',
            label: '',
            onChanged: (value) {
              ref
                  .read(createFormPageProvider.notifier)
                  .setOptionTitle(widget.fieldIndex, widget.optionIndex, value);
            },
            initialText: '',
            maxLength: null,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            if (formList[widget.fieldIndex].data.options?.length == 1) {
              showSuccessMessage(context, 'there should be atleast one option');
              return;
            }
            ref.read(createFormPageProvider.notifier).removeOptions(
                  widget.fieldIndex,
                  widget.optionIndex,
                );
          },
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
