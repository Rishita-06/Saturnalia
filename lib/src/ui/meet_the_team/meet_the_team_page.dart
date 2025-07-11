import 'dart:io';

import 'package:Saturnalia/src/constants/colors.dart';
import 'package:Saturnalia/src/logic/services/firebase_firestore.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/team_data.dart';
import '../../utils/project_utils.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class MeetTheTeamPage extends ConsumerStatefulWidget {
  const MeetTheTeamPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MeetTheTeamPageState();
}

class _MeetTheTeamPageState extends ConsumerState<MeetTheTeamPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<ProfileData>? teams;
  List<ProfileData>? ebteams;
  String title2 =
      '''Meet the powerhouse behind Saturnalia, our incredible Executive Board. Fueling the techno-cultural vibes day and night, they're the architects of this sensational event. A big round of applause for our stellar Executive Board! 🌟👏😄''';
  String title =
      '''Meet our team, the coding hermits working day and night. They may be socially distant, but their work is nothing short of perfection. Kudos to them! 🚀👏😄''';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        final res = await ref
            .read(firebaseFirestoreProvider)
            .collection('app')
            .doc('team')
            .get();
        if (res.exists) {
          if (mounted) {
            setState(() {
              if ((res.data()!['value'] as String).trim().isNotEmpty) {
                title = res.data()!['value'];
              }
              if ((res.data()!['value2'] as String).trim().isNotEmpty) {
                title2 = res.data()!['value2'];
              }
            });
          }
        }
        teams = ((res.data()?['teams'] as List?) ?? [])
            .map((e) => ProfileData.fromJson(e))
            .toList();

        ebteams = ((res.data()?['ebteams'] as List?) ?? [])
            .map((e) => ProfileData.fromJson(e))
            .toList();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: teams == null || ebteams == null
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CustomBackButton(),
                      SizedBox(width: 10),
                      CustomText2(
                        'Meet The Team',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TabBar(
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Executive Board',
                    ),
                    Tab(
                      text: 'App Team',
                    ),
                  ],
                ),
                ScrollConfiguration(
                  behavior: NoOverscrollScrollBehavior(),
                  child: Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                title2,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: NoOverscrollScrollBehavior(),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisExtent: 220,
                                      maxCrossAxisExtent: 200,
                                    ),
                                    itemCount: ebteams?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            _PersonCard(data: ebteams![index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: NoOverscrollScrollBehavior(),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisExtent: 220,
                                      maxCrossAxisExtent: 200,
                                    ),
                                    itemCount: teams?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: _PersonCard(data: teams![index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController?.dispose();
  }
}

class _PersonCard extends ConsumerWidget {
  final ProfileData data;
  const _PersonCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
        color: secondaryContainerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: data.gender == 1
                    ? secondaryColor.withOpacity(0.5)
                    : data.gender == 2
                        ? primaryColor.withOpacity(0.5)
                        : Colors.blue.withOpacity(0.5),
                child: FutureBuilder<File>(
                  future: getAvatarFile(data.userId, data.userName),
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
            const SizedBox(
              height: 6,
            ),
            Text(
              data.userName,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data.graduationYear == '2025'
                  ? '3rd Year'
                  : data.graduationYear == '2024'
                      ? '4th Year'
                      : data.graduationYear == '2027'
                          ? '1st Year'
                          : '2nd Year',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data.position,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.lato(
                fontSize: 15,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
