import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/models/reward_points_data.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:Saturnalia/src/models/reward_data.dart';
import 'package:Saturnalia/src/models/user_data.dart';
import 'package:Saturnalia/src/ui/widgets/delete_confirmation_popup.dart';
import 'package:Saturnalia/src/utils/dialog_utils.dart';
import 'package:Saturnalia/src/utils/time_utils.dart';

import '../../../constants/colors.dart';
import '../../../utils/network_utils.dart';

showRewardDetailsBottomSheet(BuildContext context, RewardData data) {
  return showSaturnaliaBottomSheet(
      context: context, builder: (context) => _RewardDetails(data: data));
}

class _RewardDetails extends ConsumerStatefulWidget {
  final RewardData data;
  const _RewardDetails({
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __RewardDetailsState();
}

class __RewardDetailsState extends ConsumerState<_RewardDetails> {
  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(appRepositoryProvider.select((value) => value.userData));
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: GoogleFonts.rocknRollOne(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Worth Rs. ${widget.data.originalValue.toStringAsFixed(1)}',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.data.imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: primaryColor,
              thickness: 2.5,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Items Left : ',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.data.itemLeft.toString(),
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: widget.data.itemLeft < 2
                        ? Colors.red
                        : Colors.white.withOpacity(0.50),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Available Till :',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  prettyTimeStamp9(widget.data.date),
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: widget.data.date.compareTo(DateTime.now()) < 0
                        ? Colors.red
                        : Colors.white.withOpacity(0.50),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (!(widget.data.description == null ||
                widget.data.description!.trim().isEmpty)) ...[
              Text(
                'Description',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data.description ?? '',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.50),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  if (widget.data.date.compareTo(DateTime.now()) < 0 ||
                      widget.data.itemLeft == 0) {
                    return;
                  }

                  showDeleteConfirmationPopup(context,
                      title: 'Are you sure you want to redeem this item ?',
                      onCancel: () {
                        context.maybePop();
                      },
                      isProcessing: false,
                      onConfirm: () async {
                        final res =
                            await _redeemItem(widget.data, userData!, ref);
                        if (res != '') {
                          showErrorMessage(context, res);
                        } else {
                          showSuccessMessage(
                              context, 'Item reedemed successfully!');
                          // context.maybePop();
                          Navigator.popUntil(
                              context,
                              (route) =>
                                  route.data?.name.toUpperCase() ==
                                  'MAINROUTE');
                        }
                      });
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: widget.data.date.compareTo(DateTime.now()) < 0 ||
                            widget.data.itemLeft == 0
                        ? Colors.grey
                        : secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 4),
                        spreadRadius: 0,
                        color: widget.data.date.compareTo(DateTime.now()) < 0 ||
                                widget.data.itemLeft == 0
                            ? Colors.grey
                            : primaryColor,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Redeem for',
                            style: GoogleFonts.rocknRollOne(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Lottie.asset(
                            'assets/lottie/coin.json',
                            repeat: false,
                            height: 35,
                          ),
                          Text(
                            ' ${widget.data.coins}',
                            style: GoogleFonts.outfit(
                              decoration: widget.data.isExclusive
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: primaryColor,
                              decorationThickness: 2,
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (widget.data.isExclusive)
                            Text(
                              ' ${widget.data.offerCoins}',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _redeemItem(
      RewardData data, UserData userData, WidgetRef ref) async {
    if (data.isExclusive) {
      if (data.offerCoins > userData.coins) {
        return 'Not enough coins to redeem this item.';
      }
    } else {
      if (data.coins > userData.coins) {
        return 'Not enough coins to redeem this item.';
      }
    }
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    const uuid = Uuid();
    final v1 = uuid.v1();
    final v2 = uuid.v1();
    try {
      await ref
          .read(firebaseFirestoreProvider)
          .collection('reedems')
          .doc('reedem-$v1')
          .set({
        'id': 'reedem-$v1',
        'userId': userData.userId,
        'userName': userData.userName,
        'email': userData.email,
        'phone': userData.phoneNumber,
        'itemId': data.id,
        'itemName': data.title,
        'imageUrl': data.imageUrl,
        'time': DateTime.now(),
        'coins': data.isExclusive ? data.offerCoins : data.coins,
        'isGiven': false,
      });
      await ref
          .read(firebaseFirestoreProvider)
          .collection('rewards')
          .doc(data.id)
          .update({
        'itemLeft': data.itemLeft - 1,
      });
      await ref
          .read(firebaseFirestoreProvider)
          .collection('users')
          .doc(userData.userId)
          .collection('rewards')
          .doc('reedem-$v2')
          .set(RewardPointsData(
                  date: DateTime.now(),
                  message: 'Item Reedemed',
                  id: 'reedem-$v2',
                  coins: data.isExclusive ? data.offerCoins : data.coins,
                  isAwarded: 2,
                  title: 'Item reedemed(${data.title})')
              .toJson());
      return '';
    } catch (e) {
      return e.toString();
    }
  }
}
