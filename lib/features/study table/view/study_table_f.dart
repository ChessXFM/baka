import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/table_helper.dart';
import 'package:game/Core/theme_helper.dart';
import '../model/study_subject_model.dart';

class StudyTableF extends StatefulWidget {
  static const String routeName = '/Study Table f';

  const StudyTableF({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'خطة الدراسة الأسبوعية',
            ),
          ),
          backgroundColor: ThemeHelper.whiteColor,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // const SizedBox(height: 20),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(color: Color.fromARGB(255, 0, 0, 0),spreadRadius: 0,
                          //       offset: Offset.zero,
                          //       blurRadius: 10,
                          //       blurStyle: BlurStyle.outer)
                          // ],
                          //border: Border.all(),
                          color: Colors.white),
                      child: Table(
                        // border: TableBorder.all(
                        //   color: Colors.black87,
                        //   width: 1,
                        // ),
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
                ),
              ],
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TableHelper.borderRadiusValue),
          color: selectedSubject?.color.withOpacity(0.2) ?? Colors.white,
        ),
        margin: const EdgeInsets.all(TableHelper.marginValue),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedSubject != null
                ? FaIcon(selectedSubject.icon, color: selectedSubject.color)
                : const Icon(Icons.add, color: Colors.black),
            const SizedBox(height: 4),
            /*    Flexible(
              child: Text(
                selectedSubject?.name ?? 'إضافة مادة',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: selectedSubject?.color ?? Colors.black),
                textAlign: TextAlign.center,
              ),
            ),*/
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
          title: const Text('اختر مادة'),
          content: SizedBox(
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
      margin: const EdgeInsets.all(TableHelper.marginValue),
      height: 50,
      color: Colors.blueAccent,
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

  TableRow buildTableTimes({required BuildContext context}) {
    return TableRow(
      children: [
        buildTimeCell('', context),
        buildTimeCell('9:00', context),
        buildTimeCell('11:00', context),
        buildTimeCell('1:00', context),
        buildTimeCell('3:00', context),
        buildTimeCell('5:00', context),
        buildTimeCell('7:00', context),
        buildTimeCell('9:00', context),
      ],
    );
  }

  Widget buildTimeCell(String time, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(TableHelper.marginValue),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(2),
        color: Colors.blueAccent,
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
}
