import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:game/features/quiz/model/quiz_model.dart';

class LocalStorageService {
  Future<void> saveQuestions(String subject ,List<Quiz> questions) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the questions to a JSON format for storage
    final questionsJson = questions
        .map((q) => {
              'question': q.question,
              'options': q.options,
              'correctAnswer': q.correctAnswer,
            })
        .toList();

    await prefs.setString('${subject}_questions', jsonEncode(questionsJson));
  }

  Future<List<Quiz>> loadQuestions(String subject) async {
    final prefs = await SharedPreferences.getInstance();
    final String? questionsString = prefs.getString('${subject}_questions');

    if (questionsString != null) {
      final List<dynamic> questionsJson = jsonDecode(questionsString);
      return questionsJson
          .map((q) => Quiz(
                id: q['id'],
                question: q['question'],
                options: List<String>.from(q['options']),
                correctAnswer: q['correctAnswer'],
              ))
          .toList();
    }
    return []; // Return an empty list if no questions found
  }
}
