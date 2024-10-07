import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:game/features/quiz/model/quiz_model.dart';

class LocalStorageService {
///////!  SHARED PREF  !///////
  Future<void> saveQuestionsWithShared(
      String subject, List<Quiz> questions) async {
    final prefs = await SharedPreferences.getInstance();

    // تحويل الأسئلة إلى تنسيق JSON للتخزين
    final questionsJson = questions.map((q) {
      return {
        'id': q.id,
        'question': q.question,
        'options': q.options,
        'correctAnswer': q.correctAnswer,
      };
    }).toList();

    await prefs.setString('${subject}_questions', jsonEncode(questionsJson));
    print("Questions saved in shared preferences for subject: $subject");
  }

  Future<List<Quiz>> loadQuestionsWithShared(String subject) async {
    final prefs = await SharedPreferences.getInstance();
    final String? questionsString = prefs.getString('${subject}_questions');

    if (questionsString != null) {
      final List<dynamic> questionsJson = jsonDecode(questionsString);

      // تأكد من صحة البيانات المسترجعة وتفادي القيم null
      List<Quiz> loadedQuestions = questionsJson.map((q) {
        return Quiz(
          id: q['id'] != null ? q['id'] : 'unknown_id', // التحقق من null
          question: q['question'] != null
              ? q['question']
              : 'Unknown question', // التحقق من null
          options: q['options'] != null
              ? List<String>.from(q['options'])
              : [], // التحقق من null
          correctAnswer: q['correctAnswer'] != null
              ? q['correctAnswer']
              : 'Unknown answer', // التحقق من null
        );
      }).toList();

      print("Questions loaded from shared preferences for subject: $subject");
      return loadedQuestions;
    }

    print('No questions found in shared preferences for subject: $subject');
    return []; // إرجاع قائمة فارغة إذا لم يتم العثور على أسئلة
  }

///////!  HIVE  !///////
// save
  Future<void> saveQuestions(String subject, List<Quiz> questions) async {
    final box = await Hive.openBox<Quiz>('quizBox');

    // Save each question in the Hive box
    for (Quiz question in questions) {
      await box.put('${subject}_${question.id}', question);
    }

    print("Questions saved in Hive for subject: $subject");
  }

// load
  Future<List<Quiz>> loadQuestions(String subject) async {
    final box = await Hive.openBox<Quiz>('quizBox');

    // Filter questions by subject and load them from the Hive box
    final questions = box.values
        .where((q) =>
            q.id.startsWith(subject)) // Assuming you tag questions with subject
        .toList();

    if (questions.isNotEmpty) {
      print("Questions loaded from Hive for subject: $subject");
      return questions.cast<Quiz>();
    }

    print('No questions found in Hive for subject: $subject');
    return [];
  }

// update
  Future<void> updateQuestions(String subject, List<Quiz> newQuestions) async {
    final box = await Hive.openBox<Quiz>('quizBox');

    for (var question in newQuestions) {
      // Replace or add new questions
      await box.put('${subject}_${question.id}', question);
    }

    print("Questions updated in Hive for subject: $subject");
  }

//
}
