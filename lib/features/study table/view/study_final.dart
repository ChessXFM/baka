import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/table_helper.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/study_subject_model.dart';
import 'dart:convert';

import 'lottie_test.dart';

class StudyTableFinal extends StatefulWidget {
  static const String routeName = '/Study Table final';
  const StudyTableFinal({super.key});

  @override
  _StudyTableFinalState createState() => _StudyTableFinalState();
}

class _StudyTableFinalState extends State<StudyTableFinal> {
  // قائمة المواد المتاحة
  final List<StudySubject> availableSubjects = [
    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
    StudySubject('اللغة الإنجليزية', FontAwesomeIcons.book, Colors.purple),
    StudySubject('علم الأحياء', FontAwesomeIcons.dna, Colors.orange),
    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
    StudySubject('التربية الوطنية', FontAwesomeIcons.flag, Colors.teal),
  ];

  // قائمة الأيام والأوقات
  final List<String> days = [
    'السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'
  ];

  final List<String> times = [
    '9:00', '11:00', '1:00', '3:00', '5:00', '7:00', '9:00'
  ];

  // قائمة المواد المختارة حسب الخانات
  Map<String, StudySubject?> selectedSubjects = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedSubjects();  // Load saved subjects from SharedPreferences on app startup
  }

  // Load subjects from SharedPreferences
  Future<void> _loadSelectedSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedSubjectsData = prefs.getString('selectedSubjects');
    if (selectedSubjectsData != null) {
      Map<String, dynamic> savedData = jsonDecode(selectedSubjectsData);
      setState(() {
        selectedSubjects = savedData.map((key, value) {
          return MapEntry(key, availableSubjects.firstWhere(
            (subject) => subject.name == value['name'],
            // orElse: () => null,
          ));
        });
      });
    }
  }

  // Save subjects to SharedPreferences
  Future<void> _saveSelectedSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataToSave = selectedSubjects.map((key, subject) {
      if (subject != null) {
        return MapEntry(key, {'name': subject.name, 'color': subject.color.toString()});
      }
      return MapEntry(key, null);
    });
    prefs.setString('selectedSubjects', jsonEncode(dataToSave));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('خطة الدراسة الأسبوعية'),
          ),
          backgroundColor: ThemeHelper.whiteColor,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: buildStudyTable(),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){}, child: const Text("حفظ")),
                  const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, TestLottie.routeName);
                }, child: const Text("حفظ")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build the complete study table
  Widget buildStudyTable() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          buildTableHeader(),
          ...days.map((day) => buildTableRow(day)).toList(),
        ],
      ),
    );
  }

  // Build header row for times
  TableRow buildTableHeader() {
    return TableRow(
      children: [
        buildTimeCell(''), // Empty cell for day column
        ...times.map((time) => buildTimeCell(time)).toList(),
      ],
    );
  }

  // Build row for each day
  TableRow buildTableRow(String day) {
    return TableRow(
      children: [
        buildDayCell(day),
        ...List.generate(7, (index) => buildSubjectCell(day, index)),
      ],
    );
  }

  // Build individual time cells
  Widget buildTimeCell(String time) {
    return Container(
      margin: const EdgeInsets.all(TableHelper.marginValue),
      decoration: BoxDecoration(
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

  // Build individual subject cells
  Widget buildSubjectCell(String day, int index) {
    String key = '$day-$index';
    StudySubject? selectedSubject = selectedSubjects[key];

    return GestureDetector(
      onTap: () => _showSubjectDialog(key, day, index),
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
          ],
        ),
      ),
    );
  }

  // Build day header cells
  Widget buildDayCell(String day) {
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

  // Show the subject selection dialog
  void _showSubjectDialog(String key, String day, int index) {
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
                  trailing: isSelected
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedSubjects[key] = subject;
                    });
                    _saveSelectedSubjects(); // Save the selection to SharedPreferences
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
}
