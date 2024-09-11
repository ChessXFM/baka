import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class StudyTable extends StatelessWidget {
  static const String routeName = '/StudyTable';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: SubjectDataSource(getSubjectData()),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 7,
          endHour: 20,
          timeIntervalHeight: 60,
        ),
        appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
          final subject = details.appointments.first;
          return Container(
            decoration: BoxDecoration(
              color: subject.color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: subject.color, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(subject.icon, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  subject.subject,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<Subject> getSubjectData() {
  return <Subject>[
    Subject(
      subject: 'Math',
      startTime: DateTime(2024, 9, 11, 9, 0),
      endTime: DateTime(2024, 9, 11, 10, 30),
      color: Colors.blue,
      icon: FontAwesomeIcons.calculator,
    ),
    Subject(
      subject: 'Physics',
      startTime: DateTime(2024, 9, 11, 11, 0),
      endTime: DateTime(2024, 9, 11, 12, 30),
      color: Colors.redAccent,
      icon: FontAwesomeIcons.atom,
    ),
    Subject(
      subject: 'Chemistry',
      startTime: DateTime(2024, 9, 12, 9, 0),
      endTime: DateTime(2024, 9, 12, 10, 30),
      color: Colors.green,
      icon: FontAwesomeIcons.flask,
    ),
    Subject(
      subject: 'Biology',
      startTime: DateTime(2024, 9, 12, 11, 0),
      endTime: DateTime(2024, 9, 12, 12, 30),
      color: Colors.orange,
      icon: FontAwesomeIcons.dna,
    ),
    Subject(
      subject: 'English',
      startTime: DateTime(2024, 9, 13, 9, 0),
      endTime: DateTime(2024, 9, 13, 10, 30),
      color: Colors.purple,
      icon: FontAwesomeIcons.book,
    ),
    Subject(
      subject: 'National Education',
      startTime: DateTime(2024, 9, 13, 11, 0),
      endTime: DateTime(2024, 9, 13, 12, 30),
      color: Colors.teal,
      icon: FontAwesomeIcons.flag,
    ),
  ];
}

class Subject {
  Subject({
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.icon,
  });

  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final IconData icon;
}

class SubjectDataSource extends CalendarDataSource {
  SubjectDataSource(List<Subject> subjects) {
    appointments = subjects;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }
}