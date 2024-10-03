import 'package:flutter/material.dart';

class StudySubject {
  final String name;
  final String arabicName;
  final IconData icon;
  final Color color;
  bool isLocked; // New property to track if the subject is locked

  StudySubject({
    required this.name,
    required this.icon,
    required this.color,
    required this.isLocked,
    required this.arabicName,
  });
}
