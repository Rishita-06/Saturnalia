import 'package:Saturnalia/src/logic/services/preference_service.dart';
import 'package:Saturnalia/src/ui/home/widgets/informal_events.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Saturnalia/src/ui/home/widgets/all_events_section.dart';
import 'package:Saturnalia/src/ui/home/widgets/home_corousal.dart';

import 'package:Saturnalia/src/utils/no_overscroll_behavior.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/repositories/events_repository/events_respository.dart';
import '../../logic/repositories/store_repository/store_repository.dart';
import '../../routing/router.dart' as router;
import '../../constants/colors.dart';
import '../../routing/router.dart';
import '../main/notification_handler.dart';
import '../notification/notification_page_model.dart';
import '../widgets/custom_scaffold.dart';
import 'home_page_model.dart';
import 'widgets/home_page_app_bar.dart';
import 'widgets/upcoming_events_section.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final isFirstTime = ref
              .read(sharedPreferencesProvider)
              .getBool(PreferenceService.isFirstTime) ??
          true;
      if (isFirstTime) {
        context.navigateTo(const TutorialRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
        systemNavigationBarColor: containerColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    final lists = ref.watch(
      homePageProvider.select((_) => _.corousalList),
    );
    ref.listen(eventsPageProvider, (previous, next) {});
    ref.listen(storeRepositoryProvider, (previous, next) {});
    ref.listen(notificationHandlerProvider, (previous, next) {});
    ref.listen(notificationPageProvider, (previous, next) {});
    final allPublicEventList = ref.watch(
      eventsPageProvider.select((_) => _.allPublicEvents),
    );

    final eventList = ref.watch(
      eventsPageProvider.select(
        (_) =>
            _.allPublicEvents
                ?.where((element) =>
                    element.details.eventDate.compareTo(
                        DateTime.now().subtract(const Duration(hours: 1))) >
                    0)
                .toList() ??
            [],
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        if (context.tabsRouter.current.path != 'home') {
          context.tabsRouter.navigate(const router.HomeRoute());
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: CustomScaffold(
          body: ScrollConfiguration(
            behavior: NoOverscrollScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 25),
                  const HomeAppBar(),
                  if (lists != null && lists.isNotEmpty) ...[
                    HomeCorousalSection(
                      data: lists,
                    ),
                  ],
                  if (eventList.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const UpComingEventsSection(),
                  ],
                  const InformalEventsSection(),
                  const SizedBox(height: 30),
                  const AllEventsSection(),
                  const SizedBox(
                    height: 30,
                  ),
                  if ((allPublicEventList?.isNotEmpty ?? false))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () async {
                          if ((allPublicEventList?.isNotEmpty ?? false)) {
                            context.navigateTo(
                                MapRoute(eventList: allPublicEventList ?? []));
                          }
                        },
                        child: Container(
                          height: 170,
                          width: 100,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/ic_map.png'),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(20),
                            color: containerColor,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: secondaryContainerColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        'See All Event Map',
                                        style: GoogleFonts.rocknRollOne(
                                          fontSize: 15,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
