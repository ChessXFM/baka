import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudySubject {
  final String name;
  final IconData icon;
  final Color color;

  StudySubject(this.name, this.icon, this.color);

  // لتحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'color': color.value,
    };
  }

  // لاسترجاع الكائن من JSON
  factory StudySubject.fromJson(Map<String, dynamic> json) {
    return StudySubject(
      json['name'],
      IconData(json['icon'], fontFamily: 'MaterialIcons'),
      Color(json['color']),
    );
  }
}

class TableStorage {
  static const String tableKey = 'weekly_table';

  // لحفظ الجدول في SharedPreferences
  static Future<void> saveTable(Map<String, StudySubject?> tableData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // تحويل البيانات إلى JSON
    String encodedData = jsonEncode(tableData.map((key, value) => MapEntry(
          key,
          value?.toJson(), // تحويل كل مادة إلى JSON
        )));

    // تخزين البيانات
    await prefs.setString(tableKey, encodedData);
  }

  // لقراءة الجدول من SharedPreferences
  static Future<Map<String, StudySubject?>> loadTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // استرجاع البيانات المشفرة
    String? encodedData = prefs.getString(tableKey);

    // إذا كانت البيانات غير موجودة، أعِد جدولًا فارغًا
    if (encodedData == null) {
      return {};
    }

    // فك ترميز البيانات
    Map<String, dynamic> decodedData = jsonDecode(encodedData);

    // إعادة بناء الجدول من JSON
    return decodedData.map((key, value) => MapEntry(
          key,
          value != null ? StudySubject.fromJson(value) : null,
        ));
  }

  // حذف الجدول
  static Future<void> clearTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tableKey);
  }
}
