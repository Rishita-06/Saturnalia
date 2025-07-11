// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:Saturnalia/src/ui/widgets/try_again_widget.dart';
import 'package:Saturnalia/src/utils/network_utils.dart';
import 'package:Saturnalia/src/utils/toast_utils.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';
import 'package:Saturnalia/src/ui/widgets/custom_text.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../../models/leaderboard_data.dart';

import '../../../utils/project_utils.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_scaffold.dart';

@RoutePage()
class LeaderBoardPage extends ConsumerStatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderBoardPageState();
}

class _LeaderBoardPageState extends ConsumerState<LeaderBoardPage> {
  int isProcessing = 1;
  int count = 0;
  List<LeaderBoardData> userData = [];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _getLeaderboardData();
    });
  }

  _getLeaderboardData() async {
    setState(() {
      isProcessing == 1;
    });
    if (!await hasInternetAccess()) {
      setState(() {
        isProcessing = 2;
      });
      return 'No internet!';
    }
    _subscription = ref
        .read(firebaseFirestoreProvider)
        .collection('users')
        .limit(100)
        .orderBy('coins', descending: true)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        userData =
            event.docs.map((e) => LeaderBoardData.fromJson(e.data())).toList();
      }
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isProcessing = 0;
        });
      });
    });
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
              'Leaderboard',
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
      ),
      body: isProcessing == 0 && userData.length > 3
          ? Column(
              children: [
                SizedBox(
                  child: FittedBox(
                    child: Row(
                      children: [
                        _LeaderboardCard2(data: userData[1], index: 1),
                        _LeaderboardCard2(data: userData[0], index: 0),
                        _LeaderboardCard2(data: userData[2], index: 2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ScrollConfiguration(
                  behavior: NoOverscrollScrollBehavior(),
                  child: Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff181818),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              index == 0 || index == 1 || index == 2
                                  ? const SizedBox()
                                  : _LeaderboardCard(
                                      data: userData[index], index: index),
                          itemCount: userData.length,
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : TryAgainWidget(
              onTap: () async {
                if (!(isProcessing == 1)) {
                  final res = await _getLeaderboardData();
                  if (res != '') {
                    showErrorMessage(context, res);
                  }
                }
              },
              noInternet: isProcessing == 2,
              isProcessing: isProcessing == 1 || userData.isEmpty,
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}

class _LeaderboardCard extends ConsumerStatefulWidget {
  final LeaderBoardData data;
  final int index;
  const _LeaderboardCard({super.key, required this.data, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __LeaderboardCardState();
}

class __LeaderboardCardState extends ConsumerState<_LeaderboardCard> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.read(
      appRepositoryProvider.select((_) => _.userData?.userId ?? ''),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: userId == widget.data.userId
                ? primaryColor.withOpacity(0.5)
                : const Color(0xff333333),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      (widget.index + 1).toString(),
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.data.gender == 1
                              ? secondaryColor
                              : widget.data.gender == 2
                                  ? primaryColor
                                  : Colors.blue,
                          width: 0.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: widget.data.gender == 1
                            ? secondaryColor.withOpacity(0.5)
                            : widget.data.gender == 2
                                ? primaryColor.withOpacity(0.5)
                                : Colors.blue.withOpacity(0.5),
                        child: FutureBuilder<File>(
                          future: getAvatarFile(
                              widget.data.userId, widget.data.userName),
                          initialData: null,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return SvgPicture.file(snapshot.data!);
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.data.userName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '${widget.data.coins}',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      height: 1.2,
                      color: primaryColor.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Lottie.asset(
                    'assets/lottie/coin.json',
                    height: 35,
                    animate: false,
                    repeat: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaderboardCard2 extends ConsumerStatefulWidget {
  final LeaderBoardData data;
  final int index;
  const _LeaderboardCard2({super.key, required this.data, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __LeaderboardCard2State();
}

class __LeaderboardCard2State extends ConsumerState<_LeaderboardCard2> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.read(
      appRepositoryProvider.select((_) => _.userData?.userId ?? ''),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.index != 0)
              const SizedBox(
                height: 50,
              ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.data.gender == 1
                          ? secondaryColor
                          : widget.data.gender == 2
                              ? primaryColor
                              : Colors.blue,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: widget.data.gender == 1
                        ? secondaryColor.withOpacity(0.5)
                        : widget.data.gender == 2
                            ? primaryColor.withOpacity(0.5)
                            : Colors.blue.withOpacity(0.5),
                    child: FutureBuilder<File>(
                      future: getAvatarFile(
                          widget.data.userId, widget.data.userName),
                      initialData: null,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SvgPicture.file(snapshot.data!);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        (widget.index + 1).toString(),
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                if (userId == widget.data.userId)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Center(
                          child: Text(
                            'YOU',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 90,
              child: Text(
                widget.data.userName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${widget.data.coins} coins',
              style: GoogleFonts.outfit(
                fontSize: 16,
                height: 1,
                color: primaryColor.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
