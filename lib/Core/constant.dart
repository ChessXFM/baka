import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features/study table/models/study_subject_model.dart';

class ScreenSizeHelper {
  static double mobileScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double mobileScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

const List<String> studySubjects = [
  'الرياضيات',
  'التربية الوطنية ',
  'علم الأحياء',
  'الفيزياء ',
  'الكيمياء',
  ' اللغة الإنجليزية',
];

class AppConstants {
  static const String quizTitle = "Quiz";
  static const String submitButtonLabel = "Submit";

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
}
