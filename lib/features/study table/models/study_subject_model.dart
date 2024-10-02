import 'package:flutter/material.dart';

class StudySubject {
  final String name;
  final IconData icon;
  final Color color;
  bool isLocked; // New property to track if the subject is locked

  StudySubject(this.name, this.icon, this.color,this.isLocked);
}
