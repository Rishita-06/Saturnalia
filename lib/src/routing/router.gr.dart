// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddEventPage]
class AddEventRoute extends PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({
    Key? key,
    EventDetails? eventData,
    List<PageRouteInfo>? children,
  }) : super(
          AddEventRoute.name,
          args: AddEventRouteArgs(
            key: key,
            eventData: eventData,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEventRouteArgs>(
          orElse: () => const AddEventRouteArgs());
      return AddEventPage(
        key: args.key,
        eventData: args.eventData,
      );
    },
  );
}

class AddEventRouteArgs {
  const AddEventRouteArgs({
    this.key,
    this.eventData,
  });

  final Key? key;

  final EventDetails? eventData;

  @override
  String toString() {
    return 'AddEventRouteArgs{key: $key, eventData: $eventData}';
  }
}

/// generated route for
/// [AddRewardsPage]
class AddRewardsRoute extends PageRouteInfo<AddRewardsRouteArgs> {
  AddRewardsRoute({
    Key? key,
    RewardData? data,
    List<PageRouteInfo>? children,
  }) : super(
          AddRewardsRoute.name,
          args: AddRewardsRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'AddRewardsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddRewardsRouteArgs>(
          orElse: () => const AddRewardsRouteArgs());
      return AddRewardsPage(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class AddRewardsRouteArgs {
  const AddRewardsRouteArgs({
    this.key,
    this.data,
  });

  final Key? key;

  final RewardData? data;

  @override
  String toString() {
    return 'AddRewardsRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [AllEventsPage]
class AllEventsRoute extends PageRouteInfo<void> {
  const AllEventsRoute({List<PageRouteInfo>? children})
      : super(
          AllEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllEventsPage();
    },
  );
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthPage();
    },
  );
}

/// generated route for
/// [CalenderPage]
class CalenderRoute extends PageRouteInfo<void> {
  const CalenderRoute({List<PageRouteInfo>? children})
      : super(
          CalenderRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalenderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CalenderPage();
    },
  );
}

/// generated route for
/// [ContactUsPage]
class ContactUsRoute extends PageRouteInfo<void> {
  const ContactUsRoute({List<PageRouteInfo>? children})
      : super(
          ContactUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactUsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactUsPage();
    },
  );
}

/// generated route for
/// [CreateAccountPage]
class CreateAccountRoute extends PageRouteInfo<CreateAccountRouteArgs> {
  CreateAccountRoute({
    Key? key,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CreateAccountRoute.name,
          args: CreateAccountRouteArgs(
            key: key,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateAccountRouteArgs>(
          orElse: () => const CreateAccountRouteArgs());
      return CreateAccountPage(
        key: args.key,
        isEditing: args.isEditing,
      );
    },
  );
}

class CreateAccountRouteArgs {
  const CreateAccountRouteArgs({
    this.key,
    this.isEditing = false,
  });

  final Key? key;

  final bool isEditing;

  @override
  String toString() {
    return 'CreateAccountRouteArgs{key: $key, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CreateFormPage]
class CreateFormRoute extends PageRouteInfo<CreateFormRouteArgs> {
  CreateFormRoute({
    Key? key,
    List<DyamicFormData>? data,
    required int minSize,
    required int maxSize,
    List<PageRouteInfo>? children,
  }) : super(
          CreateFormRoute.name,
          args: CreateFormRouteArgs(
            key: key,
            data: data,
            minSize: minSize,
            maxSize: maxSize,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateFormRouteArgs>();
      return CreateFormPage(
        key: args.key,
        data: args.data,
        minSize: args.minSize,
        maxSize: args.maxSize,
      );
    },
  );
}

class CreateFormRouteArgs {
  const CreateFormRouteArgs({
    this.key,
    this.data,
    required this.minSize,
    required this.maxSize,
  });

  final Key? key;

  final List<DyamicFormData>? data;

  final int minSize;

  final int maxSize;

  @override
  String toString() {
    return 'CreateFormRouteArgs{key: $key, data: $data, minSize: $minSize, maxSize: $maxSize}';
  }
}

/// generated route for
/// [EditCorousalPage]
class EditCorousalRoute extends PageRouteInfo<void> {
  const EditCorousalRoute({List<PageRouteInfo>? children})
      : super(
          EditCorousalRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditCorousalRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditCorousalPage();
    },
  );
}

/// generated route for
/// [EventPage]
class EventRoute extends PageRouteInfo<EventRouteArgs> {
  EventRoute({
    Key? key,
    required EventDetails data,
    bool isPreview = false,
    List<PageRouteInfo>? children,
  }) : super(
          EventRoute.name,
          args: EventRouteArgs(
            key: key,
            data: data,
            isPreview: isPreview,
          ),
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return EventPage(
        key: args.key,
        data: args.data,
        isPreview: args.isPreview,
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({
    this.key,
    required this.data,
    this.isPreview = false,
  });

  final Key? key;

  final EventDetails data;

  final bool isPreview;

  @override
  String toString() {
    return 'EventRouteArgs{key: $key, data: $data, isPreview: $isPreview}';
  }
}

/// generated route for
/// [FaqPage]
class FaqRoute extends PageRouteInfo<void> {
  const FaqRoute({List<PageRouteInfo>? children})
      : super(
          FaqRoute.name,
          initialChildren: children,
        );

  static const String name = 'FaqRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FaqPage();
    },
  );
}

/// generated route for
/// [FormPage]
class FormRoute extends PageRouteInfo<FormRouteArgs> {
  FormRoute({
    Key? key,
    required FormData data,
    bool isPreview = false,
    String eventName = '',
    String eventId = '',
    String registrationProcess = '',
    String rulesAndRegulation = '',
    List<PageRouteInfo>? children,
  }) : super(
          FormRoute.name,
          args: FormRouteArgs(
            key: key,
            data: data,
            isPreview: isPreview,
            eventName: eventName,
            eventId: eventId,
            registrationProcess: registrationProcess,
            rulesAndRegulation: rulesAndRegulation,
          ),
          initialChildren: children,
        );

  static const String name = 'FormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FormRouteArgs>();
      return FormPage(
        key: args.key,
        data: args.data,
        isPreview: args.isPreview,
        eventName: args.eventName,
        eventId: args.eventId,
        registrationProcess: args.registrationProcess,
        rulesAndRegulation: args.rulesAndRegulation,
      );
    },
  );
}

class FormRouteArgs {
  const FormRouteArgs({
    this.key,
    required this.data,
    this.isPreview = false,
    this.eventName = '',
    this.eventId = '',
    this.registrationProcess = '',
    this.rulesAndRegulation = '',
  });

  final Key? key;

  final FormData data;

  final bool isPreview;

  final String eventName;

  final String eventId;

  final String registrationProcess;

  final String rulesAndRegulation;

  @override
  String toString() {
    return 'FormRouteArgs{key: $key, data: $data, isPreview: $isPreview, eventName: $eventName, eventId: $eventId, registrationProcess: $registrationProcess, rulesAndRegulation: $rulesAndRegulation}';
  }
}

/// generated route for
/// [FunSectionPage]
class FunSectionRoute extends PageRouteInfo<void> {
  const FunSectionRoute({List<PageRouteInfo>? children})
      : super(
          FunSectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FunSectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FunSectionPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LeaderBoardPage]
class LeaderBoardRoute extends PageRouteInfo<void> {
  const LeaderBoardRoute({List<PageRouteInfo>? children})
      : super(
          LeaderBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaderBoardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LeaderBoardPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [ManageEventsPage]
class ManageEventsRoute extends PageRouteInfo<void> {
  const ManageEventsRoute({List<PageRouteInfo>? children})
      : super(
          ManageEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManageEventsPage();
    },
  );
}

/// generated route for
/// [ManageRewardsPage]
class ManageRewardsRoute extends PageRouteInfo<void> {
  const ManageRewardsRoute({List<PageRouteInfo>? children})
      : super(
          ManageRewardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageRewardsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManageRewardsPage();
    },
  );
}

/// generated route for
/// [ManageTeamPage]
class ManageTeamRoute extends PageRouteInfo<void> {
  const ManageTeamRoute({List<PageRouteInfo>? children})
      : super(
          ManageTeamRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageTeamRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManageTeamPage();
    },
  );
}

/// generated route for
/// [MapPage]
class MapRoute extends PageRouteInfo<MapRouteArgs> {
  MapRoute({
    Key? key,
    required List<EventDetails> eventList,
    List<PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            eventList: eventList,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapRouteArgs>();
      return MapPage(
        key: args.key,
        eventList: args.eventList,
      );
    },
  );
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    required this.eventList,
  });

  final Key? key;

  final List<EventDetails> eventList;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, eventList: $eventList}';
  }
}

/// generated route for
/// [MeetTheTeamPage]
class MeetTheTeamRoute extends PageRouteInfo<void> {
  const MeetTheTeamRoute({List<PageRouteInfo>? children})
      : super(
          MeetTheTeamRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeetTheTeamRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MeetTheTeamPage();
    },
  );
}

/// generated route for
/// [NoInternetPage]
class NoInternetRoute extends PageRouteInfo<NoInternetRouteArgs> {
  NoInternetRoute({
    Key? key,
    required dynamic Function(bool) onChanged,
    bool isAuth = true,
    List<PageRouteInfo>? children,
  }) : super(
          NoInternetRoute.name,
          args: NoInternetRouteArgs(
            key: key,
            onChanged: onChanged,
            isAuth: isAuth,
          ),
          initialChildren: children,
        );

  static const String name = 'NoInternetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoInternetRouteArgs>();
      return NoInternetPage(
        key: args.key,
        onChanged: args.onChanged,
        isAuth: args.isAuth,
      );
    },
  );
}

class NoInternetRouteArgs {
  const NoInternetRouteArgs({
    this.key,
    required this.onChanged,
    this.isAuth = true,
  });

  final Key? key;

  final dynamic Function(bool) onChanged;

  final bool isAuth;

  @override
  String toString() {
    return 'NoInternetRouteArgs{key: $key, onChanged: $onChanged, isAuth: $isAuth}';
  }
}

/// generated route for
/// [NotificationPage]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationPage();
    },
  );
}

/// generated route for
/// [PollPage]
class PollRoute extends PageRouteInfo<PollRouteArgs> {
  PollRoute({
    Key? key,
    required bool isEditing,
    List<PageRouteInfo>? children,
  }) : super(
          PollRoute.name,
          args: PollRouteArgs(
            key: key,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'PollRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PollRouteArgs>();
      return PollPage(
        key: args.key,
        isEditing: args.isEditing,
      );
    },
  );
}

class PollRouteArgs {
  const PollRouteArgs({
    this.key,
    required this.isEditing,
  });

  final Key? key;

  final bool isEditing;

  @override
  String toString() {
    return 'PollRouteArgs{key: $key, isEditing: $isEditing}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [QRScannnerPage]
class QRScannnerRoute extends PageRouteInfo<QRScannnerRouteArgs> {
  QRScannnerRoute({
    Key? key,
    required String eventId,
    required String eventName,
    List<PageRouteInfo>? children,
  }) : super(
          QRScannnerRoute.name,
          args: QRScannnerRouteArgs(
            key: key,
            eventId: eventId,
            eventName: eventName,
          ),
          initialChildren: children,
        );

  static const String name = 'QRScannnerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QRScannnerRouteArgs>();
      return QRScannnerPage(
        key: args.key,
        eventId: args.eventId,
        eventName: args.eventName,
      );
    },
  );
}

class QRScannnerRouteArgs {
  const QRScannnerRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
  });

  final Key? key;

  final String eventId;

  final String eventName;

  @override
  String toString() {
    return 'QRScannnerRouteArgs{key: $key, eventId: $eventId, eventName: $eventName}';
  }
}

/// generated route for
/// [QrEventListPage]
class QrEventListRoute extends PageRouteInfo<QrEventListRouteArgs> {
  QrEventListRoute({
    Key? key,
    required bool isSearching,
    List<PageRouteInfo>? children,
  }) : super(
          QrEventListRoute.name,
          args: QrEventListRouteArgs(
            key: key,
            isSearching: isSearching,
          ),
          initialChildren: children,
        );

  static const String name = 'QrEventListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QrEventListRouteArgs>();
      return QrEventListPage(
        key: args.key,
        isSearching: args.isSearching,
      );
    },
  );
}

class QrEventListRouteArgs {
  const QrEventListRouteArgs({
    this.key,
    required this.isSearching,
  });

  final Key? key;

  final bool isSearching;

  @override
  String toString() {
    return 'QrEventListRouteArgs{key: $key, isSearching: $isSearching}';
  }
}

/// generated route for
/// [ReedemCodePage]
class ReedemCodeRoute extends PageRouteInfo<void> {
  const ReedemCodeRoute({List<PageRouteInfo>? children})
      : super(
          ReedemCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReedemCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReedemCodePage();
    },
  );
}

/// generated route for
/// [ReedemItemPage]
class ReedemItemRoute extends PageRouteInfo<void> {
  const ReedemItemRoute({List<PageRouteInfo>? children})
      : super(
          ReedemItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReedemItemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReedemItemPage();
    },
  );
}

/// generated route for
/// [RewardHistoryPage]
class RewardHistoryRoute extends PageRouteInfo<void> {
  const RewardHistoryRoute({List<PageRouteInfo>? children})
      : super(
          RewardHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'RewardHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RewardHistoryPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [SponsersPage]
class SponsersRoute extends PageRouteInfo<void> {
  const SponsersRoute({List<PageRouteInfo>? children})
      : super(
          SponsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'SponsersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SponsersPage();
    },
  );
}

/// generated route for
/// [StorePage]
class StoreRoute extends PageRouteInfo<void> {
  const StoreRoute({List<PageRouteInfo>? children})
      : super(
          StoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StorePage();
    },
  );
}

/// generated route for
/// [SucessPage]
class SucessRoute extends PageRouteInfo<void> {
  const SucessRoute({List<PageRouteInfo>? children})
      : super(
          SucessRoute.name,
          initialChildren: children,
        );

  static const String name = 'SucessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SucessPage();
    },
  );
}

/// generated route for
/// [TicketPage]
class TicketRoute extends PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    Key? key,
    required EventDetails eventData,
    required EventUserData eventUserData,
    List<PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            eventData: eventData,
            eventUserData: eventUserData,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketRouteArgs>();
      return TicketPage(
        key: args.key,
        eventData: args.eventData,
        eventUserData: args.eventUserData,
      );
    },
  );
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.eventData,
    required this.eventUserData,
  });

  final Key? key;

  final EventDetails eventData;

  final EventUserData eventUserData;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, eventData: $eventData, eventUserData: $eventUserData}';
  }
}

/// generated route for
/// [TutorialPage]
class TutorialRoute extends PageRouteInfo<void> {
  const TutorialRoute({List<PageRouteInfo>? children})
      : super(
          TutorialRoute.name,
          initialChildren: children,
        );

  static const String name = 'TutorialRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TutorialPage();
    },
  );
}

/// generated route for
/// [UpdateAppPage]
class UpdateAppRoute extends PageRouteInfo<void> {
  const UpdateAppRoute({List<PageRouteInfo>? children})
      : super(
          UpdateAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateAppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UpdateAppPage();
    },
  );
}

/// generated route for
/// [UserEventsPage]
class UserEventsRoute extends PageRouteInfo<void> {
  const UserEventsRoute({List<PageRouteInfo>? children})
      : super(
          UserEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserEventsPage();
    },
  );
}

/// generated route for
/// [ViewFormResponsesPage]
class ViewFormResponsesRoute extends PageRouteInfo<ViewFormResponsesRouteArgs> {
  ViewFormResponsesRoute({
    Key? key,
    required String eventId,
    required String eventName,
    required bool hasForm,
    required FormData? data,
    List<PageRouteInfo>? children,
  }) : super(
          ViewFormResponsesRoute.name,
          args: ViewFormResponsesRouteArgs(
            key: key,
            eventId: eventId,
            eventName: eventName,
            hasForm: hasForm,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewFormResponsesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewFormResponsesRouteArgs>();
      return ViewFormResponsesPage(
        key: args.key,
        eventId: args.eventId,
        eventName: args.eventName,
        hasForm: args.hasForm,
        data: args.data,
      );
    },
  );
}

class ViewFormResponsesRouteArgs {
  const ViewFormResponsesRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
    required this.hasForm,
    required this.data,
  });

  final Key? key;

  final String eventId;

  final String eventName;

  final bool hasForm;

  final FormData? data;

  @override
  String toString() {
    return 'ViewFormResponsesRouteArgs{key: $key, eventId: $eventId, eventName: $eventName, hasForm: $hasForm, data: $data}';
  }
}
