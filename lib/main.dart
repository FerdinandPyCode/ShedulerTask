import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MeetingDataSource _events;
  late List<Appointment> _shiftCollection;

  late List<CalendarResource> _employeeCalendarResource;
  late List<TimeRegion> _specialTimeRegions;

  @override
  void initState() {
    addResourceDetails();
    addAppointments();
    addSpecialRegions();
    _events = MeetingDataSource(_shiftCollection, _employeeCalendarResource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCalendar(
                view: CalendarView.timelineMonth,
                showNavigationArrow: true,
                showWeekNumber: true,
                allowViewNavigation:true,
                allowAppointmentResize: true,
                allowDragAndDrop: true,

                //Personnalisation

                headerHeight: 40,
                //selectionDecoration: BoxDecoration(color: Colors.green),
                onTap: (v){
                  print(v.resource.toString());
                  print("${v.appointments} +++++++++++++++++");
                  print("resourceIds  : ${v.appointments![0].resourceIds}");
                  print("subject  : ${v.appointments![0].subject}");
                  print("startTime  : ${v.appointments![0].startTime}");
                  print("endTime  :  ${v.appointments![0].endTime}");
                  print("color  :  ${v.appointments![0].color}");
                },
              
                //viewNavigationMode: ViewNavigationMode.snap,
                //firstDayOfWeek: 1,
                //timeSlotViewSettings:
                    //TimeSlotViewSettings(startHour: 0, endHour:1),
                dataSource: _events,
                specialRegions: _specialTimeRegions
              )
             )
          );
  }

  void addAppointments() {
    var subjectCollection = [
      'General Meeting',
      'Plan Execution',
      'Project Plan',
      'Consulting',
      'Support',
      'Development Meeting',
      'Scrum',
      'Project Completion',
      'Release updates',
      'Performance Check'
    ];

    var colorCollection = [
      const Color(0xFF0F8644),
      const Color(0xFF8B1FA9),
      const Color(0xFFD20100),
      const Color(0xFFFC571D),
      const Color(0xFF85461E),
      const Color(0xFF36B37B),
      const Color(0xFF3D4FB5),
      const Color(0xFFE47C73),
      const Color(0xFF636363)
    ];

    _shiftCollection = <Appointment>[];
    for (var calendarResource in _employeeCalendarResource) {
      var employeeIds = [calendarResource.id];

      /*for (int j = 0; j < 365; j++) {
        for (int k = 0; k < 2; k++) {
          final DateTime date = DateTime.now().add(Duration(days: j + k));
          int startHour = 9 + Random().nextInt(6);
          startHour =
              startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
              DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: _shiftStartTime,
              endTime: _shiftStartTime.add(Duration(hours: 1)),
              subject: subjectCollection[Random().nextInt(8)],
              color: colorCollection[Random().nextInt(8)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: employeeIds
              )
            );
        }
      }*/
      //Ajout d'une tache au dashboard

      final DateTime date = DateTime.now();//.add(const Duration(days:1));
          //int startHour = 9 + Random().nextInt(6);
          //startHour =
              //startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
              DateTime(date.year, date.month, date.day+9, /*startHour*/ 0, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: _shiftStartTime,
              endTime: _shiftStartTime.add(Duration(days:Random().nextInt(3))),
              subject: subjectCollection[Random().nextInt(8)],
              color: colorCollection[Random().nextInt(8)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: employeeIds
              )
            );

    }
  }

  //Ajout des personnels à la liste

  void addResourceDetails() {
    var nameCollection = [
      'John',
      'Bryan',
      'Robert',
      'Kenny',
      'Tia',
      'Theresa',
      'Edith',
      'Brooklyn',
      'James William',
      'Sophia',
      'Elena',
      'Stephen',
      'Zoey Addison',
      'Daniel',
      'Emilia',
      'Kinsley Elena',
      'Danieals',
      'William',
      'Addison',
      'Ruby'
    ];

    var userImages = [
      'images/People_Circle5.png',
      'images/People_Circle8.png',
      'images/People_Circle18.png',
      'images/People_Circle23.png',
      'images/People_Circle25.png',
      'images/People_Circle20.png',
      'images/People_Circle13.png',
      'images/People_Circle11.png',
      'images/People_Circle27.png',
      'images/People_Circle26.png',
      'images/People_Circle24.png',
      'images/People_Circle15.png',
    ];

    _employeeCalendarResource = <CalendarResource>[];
    for (var i = 0; i < nameCollection.length; i++) {
      _employeeCalendarResource.add(CalendarResource(
          id: '000' + i.toString(),
          displayName: nameCollection[i],
          color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255), 1),
          image:null
        )
      );
    }
  }

  void addSpecialRegions() {
    final DateTime date = DateTime.now();
    _specialTimeRegions = [
      TimeRegion(
          startTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
          endTime: DateTime(date.year, date.month, date.day, 14, 0, 0),
          text: 'Lunch',
          resourceIds: _employeeCalendarResource.map((e) => e.id).toList(),
          recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
          enablePointerInteraction: false)
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection,
      List<CalendarResource> employeeCalendarResource) {
    appointments = shiftCollection;
    resources = employeeCalendarResource;
  }
}