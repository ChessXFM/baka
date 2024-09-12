import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';

import '../model/study_subject_model.dart';

Widget buildDayCell(String day, BuildContext context) {
  return Container(
    width: ScreenSizeHelper.mobileScreenWidth(context) / 9,
    padding: const EdgeInsets.all(5),
    color: ThemeHelper.accentColor,
    child: Text(
      day,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

TableRow buildTableRow(
    {required BuildContext context,
    required String day,
    required String time,
    required List<StudySubject> subjects}) {
  return TableRow(
    children: [
      buildDayCell(day, context),
      buildSubjectCell(subjects[0], context),
      buildSubjectCell(subjects[1], context),
      buildSubjectCell(subjects[2], context),
      buildSubjectCell(subjects[3], context),
      buildSubjectCell(subjects[4], context),
      buildSubjectCell(subjects[5], context),
      buildSubjectCell(subjects[6], context),
    ],
  );
}

TableRow buildTableTimes({
  required BuildContext context,
}) {
  return TableRow(
    // decoration: BoxDecoration(
    //     border: Border.all(), borderRadius: BorderRadius.circular(20)),
    children: [
      buildDayCell('', context),
      buildDayCell('04:00 AM', context),
      buildDayCell('08:00 AM', context),
      buildDayCell('01:00 PM', context),
      buildDayCell('03:00 PM', context),
      buildDayCell('05:00 PM', context),
      buildDayCell('07:00 PM', context),
      buildDayCell('09:00 PM', context),
    ],
  );
}

Widget buildSubjectCell(StudySubject subject, BuildContext context) {
  return Container(
    height: ScreenSizeHelper.mobileScreenHeight(context) / 10.5,
    padding: const EdgeInsets.all(5),
    color: subject.color.withOpacity(0.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(subject.icon, color: subject.color),
        const SizedBox(height: 4),
        Flexible(
          child: Text(
            subject.name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: subject.color),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
