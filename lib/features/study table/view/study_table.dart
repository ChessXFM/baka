import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudyTable extends StatelessWidget {
  static const String routeName = '/Study Table';
  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

   StudyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        //  backgroundColor: Colors.blueAccent,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
      children: [
        // العناوين
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildDayHeader('السبت'),
            buildDayHeader('الأحد'),
            buildDayHeader('الاثنين'),
            buildDayHeader('الثلاثاء'),
            buildDayHeader('الأربعاء'),
            buildDayHeader('الخميس'),
            buildDayHeader('الجمعة'),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 1),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                buildTableRow(
                  time: '9:00 - 10:30',
                  subjects: [
                    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
                    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
                    StudySubject('اللغة الإنجليزية', FontAwesomeIcons.book, Colors.purple),
                    StudySubject('علم الأحياء', FontAwesomeIcons.dna, Colors.orange),
                    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
                    StudySubject('التربية الوطنية', FontAwesomeIcons.flag, Colors.teal),
                    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
                  ],
                ),
                buildTableRow(
                  time: '11:00 - 12:30',
                  subjects: [
                    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
                    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
                    StudySubject('علم الأحياء', FontAwesomeIcons.dna, Colors.orange),
                    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
                    StudySubject('التربية الوطنية', FontAwesomeIcons.flag, Colors.teal),
                    StudySubject('اللغة الإنجليزية', FontAwesomeIcons.book, Colors.purple),
                    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
                  ],
                ),
                buildTableRow(
                  time: '1:00 - 2:30',
                  subjects: [
                    StudySubject('اللغة الإنجليزية', FontAwesomeIcons.book, Colors.purple),
                    StudySubject('التربية الوطنية', FontAwesomeIcons.flag, Colors.teal),
                    StudySubject('الرياضيات', FontAwesomeIcons.calculator, Colors.blue),
                    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
                    StudySubject('علم الأحياء', FontAwesomeIcons.dna, Colors.orange),
                    StudySubject('الكيمياء', FontAwesomeIcons.flask, Colors.green),
                    StudySubject('الفيزياء', FontAwesomeIcons.atom, Colors.redAccent),
                  ],
                ),
                // يمكنك إضافة المزيد من الصفوف للفترات الزمنية الأخرى
              ],
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
TableRow buildTableRow({required String time, required List<StudySubject> subjects}) {
    return TableRow(
      children: [
        buildSubjectCell(time, subjects[0]),
        buildSubjectCell(time, subjects[1]),
        buildSubjectCell(time, subjects[2]),
        buildSubjectCell(time, subjects[3]),
        buildSubjectCell(time, subjects[4]),
        buildSubjectCell(time, subjects[5]),
        buildSubjectCell(time, subjects[6]),
      ],
    );
  }

  Widget buildSubjectCell(String time, StudySubject subject) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(5),
      color: subject.color.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(subject.icon, color: subject.color),
          const SizedBox(height: 8),
          Text(
            subject.name,
            style: TextStyle(fontWeight: FontWeight.bold, color: subject.color),
            textAlign: TextAlign.center,
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey,fontSize:10),
          ),
        ],
      ),
    );
  }

  Widget buildDayHeader(String day) {
    return Expanded(
      child: Text(
        day,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class StudySubject {
  final String name;
  final IconData icon;
  final Color color;

  StudySubject(this.name, this.icon, this.color);
}