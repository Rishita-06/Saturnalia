import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:Saturnalia/src/ui/store/widgets/leaderboard_page.dart';
import 'package:Saturnalia/src/ui/store/widgets/reward_history_page.dart';
import '../models/dynamic_form_data.dart';
import '../models/event_user_data.dart';
import '../models/form_data.dart';
import '../models/reward_data.dart';

import '../models/event_details.dart';

import '../ui/contact_us/contact_us_page.dart';
import '../ui/event_page/widgets/sucess_page.dart';
import '../ui/fun_section/fun_section_page.dart';
import '../ui/manage_events/event_form_page/create_form_page.dart';
import '../ui/form_page/form_page.dart';
import '../ui/manage_events/add_event/add_event_page.dart';
import '../ui/auth/auth_page.dart';
import '../ui/calender/calender_page.dart';
import '../ui/corousal/edit_corousal_page.dart';
import '../ui/create/create_account_page.dart';
import '../ui/event_page/ticket_page/ticket_page.dart';

import '../ui/events/events_page.dart';
import '../ui/faq/faq_page.dart';
import '../ui/home/home_page.dart';
import '../ui/main/main_page.dart';
import '../ui/manage_events/view_responses_page/view_responses_page.dart';
import '../ui/manage_rewards/manage_rewards_page.dart';
import '../ui/manage_rewards/widgets/add_rewards.dart';

import '../ui/manage_teams/manage_team_page.dart';
import '../ui/manage_events/manage_event_page.dart';
import '../ui/map/events_map.dart';
import '../ui/meet_the_team/meet_the_team_page.dart';
import '../ui/no_internet/no_internet_page.dart';
import '../ui/notification/notification_page.dart';
import '../ui/poll/poll_page.dart';
import '../ui/profile/profile_page.dart';
import '../ui/qr_scanner/qr_scanner_page.dart';
import '../ui/events/event_list.dart';
import '../ui/reedem_code/reedem_code_page.dart';
import '../ui/splash/splash_page.dart';
import '../ui/event_page/event_page.dart';
import '../ui/sponsers/sponsers_page.dart';
import '../ui/store/store_page.dart';
import '../ui/store/widgets/reedem_item_page.dart';
import '../ui/tutuorial_page/tutorial_page.dart';
import '../ui/update_app/update_app_page.dart';
import '../ui/user_events/user_events_page.dart';
part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: SplashRoute.page,
    ),
    AutoRoute(
      path: '/auth',
      page: AuthRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/main',
      page: MainRoute.page,
      // guards: [AuthGuard()],
      children: [
        AutoRoute(
          path: 'home',
          page: HomeRoute.page,
          // guards: [AuthGuard()],
        ),
        AutoRoute(
          path: 'calender',
          page: CalenderRoute.page,
          // guards: [AuthGuard()],
        ),
        AutoRoute(
          path: 'user-events',
          page: UserEventsRoute.page,
          // guards: [AuthGuard()],
        ),
        AutoRoute(
          path: 'store',
          page: StoreRoute.page,
          // guards: [AuthGuard()],
        ),
        AutoRoute(
          path: 'profile',
          page: ProfileRoute.page,
          // guards: [AuthGuard()],
        ),
      ],
    ),
    AutoRoute(
      path: '/event-page',
      page: EventRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/events',
      page: AllEventsRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/scan-qr',
      page: QRScannnerRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/no-internet',
      page: NoInternetRoute.page,
    ),
    AutoRoute(
      path: '/map-page',
      page: MapRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/sponser',
      page: SponsersRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/ticket-page',
      page: TicketRoute.page,
    ),
    AutoRoute(
      path: '/notifcation',
      page: NotificationRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/add-event',
      page: AddEventRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/reward-history',
      page: RewardHistoryRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/create',
      page: CreateAccountRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/leaderboard',
      page: LeaderBoardRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/update',
      page: UpdateAppRoute.page,
    ),
    AutoRoute(
      path: '/faq',
      page: FaqRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/manage-teams',
      page: ManageTeamRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/corousal',
      page: EditCorousalRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/manage-events',
      page: ManageEventsRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/manage-rewards',
      page: ManageRewardsRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/add-rewards',
      page: AddRewardsRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/create-event-forms',
      page: CreateFormRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/event-forms',
      page: FormRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/sucess-register',
      page: SucessRoute.page,
    ),
    AutoRoute(
      path: '/qr-event-list',
      page: QrEventListRoute.page,
    ),
    AutoRoute(
      path: '/reedem-items',
      page: ReedemItemRoute.page,
    ),
    AutoRoute(
      path: '/contact-us',
      page: ContactUsRoute.page,
    ),
    AutoRoute(
      path: '/view-form',
      page: ViewFormResponsesRoute.page,
    ),
    AutoRoute(
      path: '/tutorial-page',
      page: TutorialRoute.page,
    ),
    AutoRoute(
      path: '/meet-the-team',
      page: MeetTheTeamRoute.page,
    ),
    AutoRoute(
      path: '/poll',
      page: PollRoute.page,
    ),
    AutoRoute(
      path: '/fun-section',
      page: FunSectionRoute.page,
    ),
    AutoRoute(
      path: '/reedem-code',
      page: ReedemCodeRoute.page,
    ),
  ];
}
