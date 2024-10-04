import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/study_subject_model.dart';

class StudyTableFinal extends StatefulWidget {
  static const String routeName = '/Study Table final';
  const StudyTableFinal({super.key});

  @override
  _StudyTableFinalState createState() => _StudyTableFinalState();
}

class _StudyTableFinalState extends State<StudyTableFinal>
    with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final List<StudySubject> availableSubjects = [
    StudySubject(
      name: 'Math1',
      arabicName: 'الرياضيات الجزء الأوّل',
      icon: FontAwesomeIcons.calculator,
      color: Colors.blue,
      isLocked: true,
    ),
    StudySubject(
      name: 'Math2',
      arabicName: 'الرياضيات الجزء الثاني',
      icon: FontAwesomeIcons.calculator,
      color: Colors.blue,
      isLocked: true,
    ),
    StudySubject(
        name: 'Physics',
        arabicName: 'الفيزياء',
        icon: FontAwesomeIcons.atom,
        color: Colors.redAccent,
        isLocked: true),
    StudySubject(
        name: 'English',
        arabicName: 'اللغة الإنجليزية',
        icon: FontAwesomeIcons.book,
        color: Colors.purple,
        isLocked: true),
    StudySubject(
        name: 'Biology',
        arabicName: 'علم الأحياء',
        icon: FontAwesomeIcons.dna,
        color: Colors.orange,
        isLocked: true),
    StudySubject(
        name: 'Chemistry',
        arabicName: 'الكيمياء',
        icon: FontAwesomeIcons.flask,
        color: Colors.green,
        isLocked: true),
    StudySubject(
        name: 'National',
        arabicName: 'التربية الوطنية',
        icon: FontAwesomeIcons.flag,
        color: Colors.teal,
        isLocked: true),
  ];

  final List<String> days = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد'
  ];
  final List<String> daysDisplayOrder = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة'
  ];

  final List<String> times = [
    '9:00',
    '11:00',
    '13:00',
    '15:00',
    '17:00',
    '19:00',
    '21:00'
  ];

  Map<String, StudySubject?> selectedSubjects = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedSubjects();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Damascus'));

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadSelectedSubjects();
    }
  }

  Future<void> _loadSelectedSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedSubjectsData = prefs.getString('selectedSubjects');
    if (selectedSubjectsData != null) {
      Map<String, dynamic> savedData = jsonDecode(selectedSubjectsData);
      setState(() {
        selectedSubjects = savedData.map((key, value) {
          return MapEntry(
            key,
            availableSubjects.firstWhere(
              (subject) => subject.name == value['name'],
            ),
          );
        });
      });
    }
  }

  Future<void> _saveSelectedSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataToSave = selectedSubjects.map((key, subject) {
      if (subject != null) {
        return MapEntry(
            key, {'name': subject.name, 'color': subject.color.toString()});
      }
      return MapEntry(key, null);
    });
    prefs.setString('selectedSubjects', jsonEncode(dataToSave));
  }

  Future<void> _scheduleNotification(
      String key, String day, String time, StudySubject subject) async {
    final dayIndex = days.indexOf(day) + 1;

    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    tz.TZDateTime scheduledDate =
        _nextInstanceOfDayAndTime(dayIndex, hour, minute);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      key.hashCode,
      'تذكير بالمادة الدراسية',
      'حان وقت ${subject.name}',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'study_schedule_channel',
          'Study Schedule',
          channelDescription: 'Notifications for study schedule',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _cancelNotification(String key) async {
    await flutterLocalNotificationsPlugin.cancel(key.hashCode);
  }

  tz.TZDateTime _nextInstanceOfDayAndTime(int dayOfWeek, int hour, int minute) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    while (scheduledDate.weekday != dayOfWeek || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // backgroundColor: ThemeHelper.otherprimaryColor,
          appBar: AppBar(
            // backgroundColor: ThemeHelper.primaryColor,
            centerTitle: true,
            title: const Text(
              'خطة الدراسة الأسبوعية',
            ),
          ),
          // backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: buildStudyTable(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              ThemeHelper.otherprimaryColor)),
                      onPressed: _showClearAllDialog,
                      child: const Text("حذف جميع المواد"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudyTable() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: ThemeHelper.primaryColor),
        borderRadius: BorderRadius.circular(8),
        color: ThemeHelper.primaryColor.withOpacity(0.3),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          buildTableHeader(),
          ...daysDisplayOrder.map((day) => buildTableRow(day)).toList(),
        ],
      ),
    );
  }

  TableRow buildTableHeader() {
    return TableRow(
      children: [
        buildTimeCell(''),
        ...times.map((time) => buildTimeCell(time)).toList(),
      ],
    );
  }

  TableRow buildTableRow(String day) {
    return TableRow(
      children: [
        buildDayCell(day),
        ...List.generate(7, (index) => buildSubjectCell(day, index)),
      ],
    );
  }

  Widget buildTimeCell(String time) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ThemeHelper.otherprimaryColor,
      ),
      height: 50,
      alignment: Alignment.center,
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSubjectCell(String day, int index) {
    String key = '$day-$index';
    StudySubject? selectedSubject = selectedSubjects[key];

    return GestureDetector(
      onTap: () => _showSubjectDialog(key, day, times[index]),
      onLongPress: () {
        if (selectedSubject != null) {
          _showRemoveDialog(key, selectedSubject);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedSubject?.color.withOpacity(0.2) ??
              ThemeHelper.accentColor,
        ),
        margin: const EdgeInsets.all(4.0),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedSubject != null
                ? FaIcon(selectedSubject.icon, color: selectedSubject.color)
                : const Icon(Icons.add, color: Colors.black),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget buildDayCell(String day) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ThemeHelper.otherprimaryColor,
      ),
      margin: const EdgeInsets.all(4.0),
      height: 50,
      // color: ThemeHelper.secondaryColor,
      alignment: Alignment.center,
      child: Text(
        day,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showSubjectDialog(String key, String day, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر مادة'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableSubjects.length,
              itemBuilder: (BuildContext context, int index) {
                StudySubject subject = availableSubjects[index];
                bool isSelected = selectedSubjects[key] == subject;

                return ListTile(
                  leading: FaIcon(subject.icon, color: subject.color),
                  title: Text(subject.name),
                  tileColor: isSelected ? Colors.grey[300] : null,
                  onTap: () async {
                    setState(() {
                      selectedSubjects[key] = subject;
                    });
                    await _scheduleNotification(key, day, time, subject);
                    await _saveSelectedSubjects();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showRemoveDialog(String key, StudySubject subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: Text('هل أنت متأكد أنك تريد إزالة ${subject.name}؟'),
            actions: <Widget>[
              TextButton(
                child: const Text('نعم'),
                onPressed: () async {
                  setState(() {
                    selectedSubjects[key] = null;
                  });
                  await _cancelNotification(key);
                  await _saveSelectedSubjects();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('لا'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('تأكيد حذف جميع المواد'),
            content: const Text('هل أنت متأكد أنك تريد حذف جميع المواد؟'),
            actions: <Widget>[
              TextButton(
                child: const Text('نعم'),
                onPressed: () async {
                  setState(() {
                    selectedSubjects.clear(); // حذف جميع المواد
                  });
                  await flutterLocalNotificationsPlugin
                      .cancelAll(); // إلغاء جميع الإشعارات
                  await _saveSelectedSubjects(); // حفظ التغييرات
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('لا'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
