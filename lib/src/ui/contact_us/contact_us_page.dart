import 'package:Saturnalia/src/ui/contact_us/contact_us_model.dart';
import 'package:Saturnalia/src/ui/contact_us/widgets/contact_us_box.dart';
import 'package:Saturnalia/src/ui/contact_us/widgets/contact_us_form.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ContactUsPage extends ConsumerStatefulWidget {
  const ContactUsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ContactUsPageState();
}

class ContactUsPageState extends ConsumerState<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final status =
        ref.watch(contactUsPageProvider.select((value) => value.status));
         final data=ref.watch(contactUsPageProvider.select((value) => value.data));
    return SafeArea(
      child: Scaffold(
        body: status == ContactUsPageStatus.loaded
            ? const ContactUsForm()
            : status == ContactUsPageStatus.loadedAndPendingQuery
                ? ContactUsBox(data: data!,)
                : TryAgainWidget(
                    onTap: () {
                      ref.read(contactUsPageProvider.notifier).init();
                    },
                    noInternet: status == ContactUsPageStatus.noInternet,
                    isProcessing: status == ContactUsPageStatus.initial ||
                        status == ContactUsPageStatus.loading || data==null,
                  ),
      ),
    );
  }
}
