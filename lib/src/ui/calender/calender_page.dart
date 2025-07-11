import 'package:Saturnalia/src/routing/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../logic/repositories/events_repository/events_respository.dart';
import '../../models/event_details.dart';
import '../../utils/calender_utlis.dart';
import '../../utils/no_overscroll_behavior.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text.dart';

@RoutePage()
class CalenderPage extends ConsumerStatefulWidget {
  const CalenderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalenderPageState();
}

class _CalenderPageState extends ConsumerState<CalenderPage> {
  List<Meeting> _getDataSource(List<EventDetails> data) {
    final List<Meeting> meetings = <Meeting>[];
    for (EventDetails datas in data) {
      meetings.add(
        Meeting(
          datas.details.title,
          datas.details.eventDate,
          datas.details.eventEndDate ??
              datas.details.eventDate.add(const Duration(hours: 2)),
          secondaryContainerColor,
          false,
          datas,
        ),
      );
    }

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    final eventsList = ref.watch(
      eventsPageProvider.select(
        (_) => _.allPublicEvents,
      ),
    );
    return SafeArea(
      child: CustomScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: CustomText(
                'Calendar',
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoOverscrollScrollBehavior(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SfCalendar(
                    view: CalendarView.schedule,
                    todayHighlightColor: containerColor,
                    minDate: DateTime(2023, 11, 23),
                    maxDate: DateTime(2023, 11, 27),
                    todayTextStyle: GoogleFonts.outfit(
                      color: Colors.white,
                    ),
                    // headerHeight: ,
                    headerStyle: CalendarHeaderStyle(
                      textStyle: GoogleFonts.rocknRollOne(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    scheduleViewSettings: ScheduleViewSettings(
                      hideEmptyScheduleWeek: true,
                      placeholderTextStyle:
                          GoogleFonts.outfit(color: Colors.white),
                      monthHeaderSettings: MonthHeaderSettings(
                        monthTextStyle: GoogleFonts.rocknRollOne(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      dayHeaderSettings: DayHeaderSettings(
                        dayTextStyle: GoogleFonts.outfit(color: Colors.white),
                        dateTextStyle: GoogleFonts.outfit(color: Colors.white),
                      ),
                    ),
                    scheduleViewMonthHeaderBuilder: (context, details) =>
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      child: Image.asset(
                        'assets/images/sat_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: (calendarTapDetails) {
                      if(calendarTapDetails.appointments!=null ){
                        if(calendarTapDetails.targetElement.index>2){
                      context.navigateTo(EventRoute(
                          data: (calendarTapDetails.appointments![
                                  calendarTapDetails.targetElement.index -
                                      3] as Meeting)
                              .eventId));
                        }
                    }},

                    cellEndPadding: 5,

                    dataSource:
                        MeetingDataSource(_getDataSource(eventsList ?? [])),
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: ScrollConfiguration(
            //     behavior: NoOverscrollScrollBehavior(),
            //     child: EventCalendar(
            //         eventOptions: EventOptions(
            //           emptyIconColor: scaffoldColor,
            //           emptyIcon: Icons.free_cancellation,
            //           emptyText: '',
            //         ),
            //         middleWidget: (date) {
            //           return Container(
            //             decoration: const BoxDecoration(
            //               color: containerColor,
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(10),
            //                 topRight: Radius.circular(10),
            //               ),
            //             ),
            //             width: MediaQuery.sizeOf(context).width,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 20, vertical: 20),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     '${date.day} ${DateFormat('MMMM').format(DateTime(0, date.month))}',
            //                     style: GoogleFonts.outfit(
            //                       fontSize: 18,
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   Text(
            //                     'Events',
            //                     style: GoogleFonts.outfit(
            //                       fontSize: 22,
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //         showEvents: false,
            //         showLoadingForEvent: false,
            //         headerOptions: HeaderOptions(
            //           navigationColor: primaryColor,
            //           monthStringType: MonthStringTypes.SHORT,
            //           weekDayStringType: WeekDayStringTypes.SHORT,
            //           headerTextColor: Colors.white,
            //         ),
            //         calendarOptions: CalendarOptions(
            //           headerMonthBackColor: containerColor,
            //           viewType: ViewType.DAILY,
            //           headerMonthShape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           bottomSheetBackColor: containerColor,
            //           headerMonthElevation: 5,
            //         ),
            //         dayOptions: DayOptions(
            //           disableFadeEffect: true,
            //           weekDaySelectedColor: Colors.white,
            //           weekDayUnselectedColor: Colors.white,
            //           disableDaysBeforeNow: true,
            //           compactMode: true,
            //           disabledTextColor: Colors.white,
            //           unselectedTextColor: Colors.white,
            //           selectedBackgroundColor: primaryColor,
            //           unselectedBackgroundColor: Colors.transparent,
            //           eventCounterColor: Colors.white,
            //           eventCounterViewType: DayEventCounterViewType.LABEL,
            //           eventCounterTextColor: Colors.pink,
            //         ),
            //         calendarType: CalendarType.GREGORIAN,
            //         calendarLanguage: 'en',
            //         dateTime: CalendarDateTime(
            //           year: 2023,
            //           month: 11,
            //           day: 23,
            //           calendarType: CalendarType.GREGORIAN,
            //         ),
            //         events: eventsList
            //             ?.map(
            //               (e) => Event(
            //                 child: EventInfoCard(
            //                   onTap: () {
            //                     context.navigateTo(
            //                       EventRoute(data: e),
            //                     );
            //                   },
            //                   data: e,
            //                   isVisible: true,
            //                 ),
            //                 dateTime: CalendarDateTime(
            //                   year: e.details.eventDate.year,
            //                   month: e.details.eventDate.month,
            //                   day: e.details.eventDate.day,
            //                   calendarType: CalendarType.GREGORIAN,
            //                 ),
            //               ),
            //             )
            //             .toList()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
