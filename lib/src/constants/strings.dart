// ignore_for_file: slash_for_doc_comments

import 'dart:io';

Map<int, String> team = {
  0: "Team Manager",
  1: "Event Editor",
  2: "Event Manager",
  3: "Outreach Team",
  4: "Qr Code Scanner",
  5: "Corousal Manager",
  6: "Rewards Manager",
  7: "Polls Manager"
};
Map<int, String> teams = {
  1: "Admin",
  3: "Maintainer",
  4: "Team Member",
  5: "Outreach",
};
Map<int, String> adminTeams = {
  4: "Team Member",
};
/** roles
  bool isAdmin=true(can do everything(like super admin))
  if role is empty and isAdmin  is false,then it is normal user
  0 team manager(can only add roles)
  1 event maintainer(only edit),
  2 event adder(add and delete their respective events),
  3 outreach (can only view responses)
  4 team member(can only scan qr),
  5 corousal adder,
  6 rewards adder,
  7 polls adder,
  **/

const formTypes = [
  {0: 'Short Text'},
  {1: 'Long Text'},
  {2: 'Link'},
  {3: 'Number'},
  {4: 'Drop Down'},
  {5: 'Image'},
];

enum EventVisibility {
  forThaparOnly, //1
  openForAll, //2
}

enum EventType {
  viewOnly, //1
  participationOnly, //2
  openParticipationForNow, //3
  openParticipationAndView, //4
}

enum TeamType {
  solo, //1
  group, //2
}

final storeUrl = Platform.isIOS
    ? 'https://apps.apple.com/us/app/saturnalia/id6470720810'
    : 'https://play.google.com/store/apps/details?id=com.saturnalia.saturnalia_app';
