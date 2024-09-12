import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/features/study%20table/view/study_table_functions.dart';

import '../model/study_subject_model.dart';

class StudyTableF extends StatelessWidget {
  static const String routeName = '/Study Table f';
  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: ThemeHelper.accentColor,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
			   const SizedBox(height: 10),
			  Text('خطة الدراسة الأسبوعية',style: TextStyle(fontSize: 20 ,fontWeight:FontWeight.bold)),
                // العناوين
                /*  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDayCell(days[0], context),
                    buildDayCell(days[1], context),
                    buildDayCell(days[2], context),
                    buildDayCell(days[3], context),
                    buildDayCell(days[4], context),
                    buildDayCell(days[5], context),
                    buildDayCell(days[6], context),
                  ],
                ),
*/
                const SizedBox(height: 10),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                       // borderRadius: BorderRadius.circular(20),
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        buildTableTimes(context: context),
                        buildTableRow(
                          context: context,
                          day: 'السبت',
                          time: '9:00 - 10:30',
                          subjects: [
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الأحد',
                          time: '11:00 - 12:30',
                          subjects: [
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الاثنين',
                          time: '1:00 - 2:30',
                          subjects: [
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الثلاثاء',
                          time: '1:00 - 2:30',
                          subjects: [
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الأربعاء',
                          time: '1:00 - 2:30',
                          subjects: [
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الخميس',
                          time: '1:00 - 2:30',
                          subjects: [
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                          ],
                        ),
                        buildTableRow(
                          context: context,
                          day: 'الجمعة',
                          time: '1:00 - 2:30',
                          subjects: [
                            StudySubject('اللغة الإنجليزية',
                                FontAwesomeIcons.book, Colors.purple),
                            StudySubject('التربية الوطنية',
                                FontAwesomeIcons.flag, Colors.teal),
                            StudySubject('الرياضيات',
                                FontAwesomeIcons.calculator, Colors.blue),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
                            StudySubject('علم الأحياء', FontAwesomeIcons.dna,
                                Colors.orange),
                            StudySubject('الكيمياء', FontAwesomeIcons.flask,
                                Colors.green),
                            StudySubject('الفيزياء', FontAwesomeIcons.atom,
                                Colors.redAccent),
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
}
