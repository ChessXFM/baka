import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/features/study%20table/view/study_table_functions.dart';
import '../model/study_subject_model.dart';

class StudyTableF extends StatefulWidget {
  static const String routeName = '/Study Table f';

  @override
  _StudyTableFState createState() => _StudyTableFState();
}

class _StudyTableFState extends State<StudyTableF> {
  // قائمة المواد المتاحة
  List<StudySubject> availableSubjects = [
    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
    StudySubject('اللغة الإنجليزية', FontAwesomeIcons.book, Colors.purple),
    StudySubject('علم الأحياء', FontAwesomeIcons.dna, Colors.orange),
    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
    StudySubject('التربية الوطنية', FontAwesomeIcons.flag, Colors.teal),
  ];

  // قائمة المواد المختارة حسب الخانات
  Map<String, StudySubject?> selectedSubjects = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage('assets/images/background.jpg'),
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text('خطة الدراسة الأسبوعية',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 100),
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          buildTableTimes(context: context),
                          buildTableRow(
                            context: context,
                            day: 'السبت',
                            time: '9:00 - 10:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الأحد',
                            time: '11:00 - 12:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الاثنين',
                            time: '1:00 - 2:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الثلاثاء',
                            time: '3:00 - 4:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الأربعاء',
                            time: '5:00 - 6:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الخميس',
                            time: '7:00 - 8:30',
                          ),
                          buildTableRow(
                            context: context,
                            day: 'الجمعة',
                            time: '9:00 - 10:30',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow({
    required BuildContext context,
    required String day,
    required String time,
  }) {
    return TableRow(
      children: [
        buildDayCell(day, context),
        buildSubjectCell(day, 0),
        buildSubjectCell(day, 1),
        buildSubjectCell(day, 2),
        buildSubjectCell(day, 3),
        buildSubjectCell(day, 4),
        buildSubjectCell(day, 5),
        buildSubjectCell(day, 6),
      ],
    );
  }

  Widget buildSubjectCell(String day, int index) {
    String key = '$day-$index';
    StudySubject? selectedSubject = selectedSubjects[key];

    return GestureDetector(
      onTap: () {
        _showSubjectDialog(key);
      },
      child: Container(
        height: 50,
        color: selectedSubject?.color.withOpacity(0.2) ?? Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedSubject != null
                ? FaIcon(selectedSubject.icon, color: selectedSubject.color)
                : Icon(Icons.add, color: Colors.black),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                selectedSubject?.name ?? 'إضافة مادة',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: selectedSubject?.color ?? Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubjectDialog(String key) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختر مادة'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableSubjects.length,
              itemBuilder: (BuildContext context, int index) {
                StudySubject subject = availableSubjects[index];
                return ListTile(
                  leading: FaIcon(subject.icon, color: subject.color),
                  title: Text(subject.name),
                  onTap: () {
                    setState(() {
                      selectedSubjects[key] = subject;
                    });
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

  Widget buildDayCell(String day, BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  TableRow buildTableTimes({required BuildContext context}) {
    return TableRow(
      children: [
        buildTimeCell('اليوم', context),
        buildTimeCell('9:00 - 10:30', context),
        buildTimeCell('11:00 - 12:30', context),
        buildTimeCell('1:00 - 2:30', context),
        buildTimeCell('3:00 - 4:30', context),
        buildTimeCell('5:00 - 6:30', context),
        buildTimeCell('7:00 - 8:30', context),
        buildTimeCell('9:00 - 10:30', context),
      ],
    );
  }

  Widget buildTimeCell(String time, BuildContext context) {
    return Container(
      height: 50,
      color: Colors.pink[300],
      alignment: Alignment.center,
      child: Text(
        time,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
