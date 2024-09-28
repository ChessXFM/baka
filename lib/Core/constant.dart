import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static double mobileScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double mobileScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
const List<String>studySubjects =[
  'الرياضيات',
'التربية الوطنية ' ,
'علم الأحياء',
'الفيزياء ',
'الكيمياء',
' اللغة الإنجليزية',
];
class AppConstants {
  static const String quizTitle = "Quiz";
  static const String submitButtonLabel = "Submit";
}
