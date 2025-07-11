import 'package:Saturnalia/src/utils/network_utils.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:Saturnalia/src/models/reedem_item_data.dart';
import 'package:Saturnalia/src/ui/widgets/custom_scaffold.dart';
import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../../constants/colors.dart';
import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../utils/time_utils.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';

@RoutePage()
class ReedemItemPage extends ConsumerStatefulWidget {
  const ReedemItemPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReedemItemPageState();
}

class _ReedemItemPageState extends ConsumerState<ReedemItemPage> {
  bool isProcessing = true;
  String errorMessage = '';
  List<ReedemItemData> data = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getItemList();
    });
  }

  getItemList() async {
    if (mounted) {
      setState(() {
        errorMessage = '';
        isProcessing = true;
      });
      if (!await hasInternetAccess()) {
        setState(() {
          isProcessing = false;
          errorMessage = '2';
        });
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
      final userId = ref
          .read(appRepositoryProvider.select((_) => _.userData?.userId ?? ''));
      final res = await ref
          .read(firebaseFirestoreProvider)
          .collection('reedems')
          .where('userId', isEqualTo: userId)
          .get();
      if (res.docs.isEmpty) {
        setState(() {
          errorMessage = 'Something Went Wrong';
          isProcessing = false;
        });
      } else {
        data = res.docs.map((e) => ReedemItemData.fromJson(e.data())).toList();
        if (mounted) {
          setState(() {
            errorMessage = '';
            isProcessing = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Row(
          children: [
            CustomBackButton(),
            SizedBox(
              width: 10,
            ),
            CustomText2(
              'Your Items',
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
      ),
      body: isProcessing
          ? TryAgainWidget(
              onTap: () {},
              isProcessing: isProcessing,
            )
          : errorMessage != ''
              ? TryAgainWidget(
                  onTap: () async {
                    await getItemList();
                  },
                  noInternet: errorMessage == '2',
                  isProcessing: isProcessing,
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ScrollConfiguration(
                    behavior: NoOverscrollScrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: data
                            .map(
                              (e) => _ReedemItemCard(data: e),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
    ));
  }
}

class _ReedemItemCard extends ConsumerWidget {
  final ReedemItemData data;
  const _ReedemItemCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryContainerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: data.imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Item :',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data.itemName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.lato(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Cost : ',
                          style: GoogleFonts.rocknRollOne(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 25,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Row(
                                children: [
                                  Lottie.asset(
                                    'assets/lottie/coin.json',
                                    repeat: false,
                                  ),
                                  Text(
                                    data.coins.toString(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Purchased on :',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          prettyTimeStamp9(data.time),
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.50),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Is Given : ',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          data.isGiven ? "Given" : "Pending",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: data.isGiven ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
