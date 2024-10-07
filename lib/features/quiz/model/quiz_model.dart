import 'package:hive/hive.dart';

part 'quiz_model.g.dart'; // Ensure this line is present

@HiveType(typeId: 0)
class Quiz extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final List<String> options;

  @HiveField(3)
  final String correctAnswer;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
