// ignore_for_file: use_build_context_synchronously

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/repositories/events_repository/events_respository.dart';
import 'package:Saturnalia/src/ui/contact_us/contact_us_model.dart';
import 'package:Saturnalia/src/ui/widgets/custom_button.dart';

import 'package:Saturnalia/src/ui/widgets/custom_text_field.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/back_button.dart';
import '../../widgets/custom_sat_drop_down.dart';
import '../../widgets/custom_text.dart';


class ContactUsForm extends ConsumerStatefulWidget {
  const ContactUsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends ConsumerState<ContactUsForm> {
  bool isProcessing=false;
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsPageProvider.select((value) =>
        value.allPublicEvents?.map((e) => {e.details.title: e.details.title})));
    final query=ref.watch(contactUsPageProvider.select((value) => value.issueTitle));
    return ScrollConfiguration(
      behavior: NoOverscrollScrollBehavior(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  CustomBackButton(),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText2(
                    'Contact Us',
                    size: 28,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (events != null)
                CustomSatDropDownButton<String>(
                  backgroundColor: secondaryContainerColor,
                  selectedId: query,
                  width: 200,
                  initialText: 'Select Query',
                  onChanged: (value) {
                    ref.read(contactUsPageProvider.notifier).setQuery(value);
                  },
                  data: [
                    const {'App Query': 'App Query'},
                    const {'Other Query': 'Other Query'},
                    ...events
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Write your query here',
                label: 'Description',
                onChanged: (value) {
                  ref.read(contactUsPageProvider.notifier).setDescription(value);
                },
                initialText: ref.read(contactUsPageProvider.select((value) => value.description)),
                maxLength: 1500,
                isShowMaxLength: true,
                maxlines: 15,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                onTap: () async{
                  if(!isProcessing){
                    setState(() {
                      isProcessing=true;
                    });
                    final res= await ref.read(contactUsPageProvider.notifier).sendQuery();
                    if(res!=''){
                      showErrorMessage(context,res);
                      setState(() {
                        isProcessing=false;
                      });
                    }else{
                      showSuccessMessage(context, 'Query Submitted Successfully');
                    }
                  }


                },
                text: 'Submit',
                isProcessing: isProcessing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
