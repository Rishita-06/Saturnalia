import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Saturnalia/src/logic/repositories/store_repository/store_repository.dart';
import 'package:Saturnalia/src/ui/main/widgets/app_drawer.dart';
import 'package:Saturnalia/src/ui/notification/notification_page_model.dart';
import '../../constants/colors.dart';
import '../../logic/repositories/events_repository/events_respository.dart';
import '../../logic/repositories/app_repository/app_repository.dart';

import '../../routing/router.dart';
import '../widgets/bottom_bar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     ref.read(notificationHandlerProvider.notifier).onUiInit(context);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    // ref.read(notificationHandlerProvider.notifier).onUiDispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: containerColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    ref.listen(eventsPageProvider, (previous, next) {});
    ref.listen(storeRepositoryProvider, (previous, next) {});
    // ref.listen(notificationHandlerProvider, (previous, next) {});
    ref.listen(notificationPageProvider, (previous, next) {});
    ref.listen(appRepositoryProvider, (prev, next) {
      if (prev?.status != next.status) {
        if (next.status == AppStatus.unauthenticated) {
          context.replaceRoute(const AuthRoute());
        }
        if (next.status == AppStatus.createAccount) {
          context.replaceRoute(CreateAccountRoute());
        }
      }
    });
    final isAdmin = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.isAdmin),
        ) ??
        false;
    final roles = ref.watch(
          appRepositoryProvider.select((_) => _.userData?.roles),
        ) ??
        [];

    return AutoTabsScaffold(
      scaffoldKey: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      animationCurve: Curves.bounceInOut,
      drawer: (isAdmin || roles.isNotEmpty)
          ? Drawer(
              width: 250,
              backgroundColor: Colors.black,
              child: AppDrawer(
                mainContext: context,
              ),
            )
          : null,
      routes: const [
        HomeRoute(),
        CalenderRoute(),
        StoreRoute(),
        UserEventsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomBar(
        key: ValueKey(tabsRouter.activeIndex),
      ),
    );
  }
}
