import 'package:flutter/material.dart';

import '../model/quiz_model.dart';

class ReviewScreen extends StatelessWidget {
  static const String routeName = '/Review Screen';
  final List<Quiz> questions;
  final List<String> userAnswers;

  const ReviewScreen(
      {super.key, required this.questions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Review")),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswer = userAnswers[index];
          final isCorrect = userAnswer == question.correctAnswer;

          return ListTile(
            title: Text(question.question),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Answer: $userAnswer",
                    style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red)),
                Text("Correct Answer: ${question.correctAnswer}",
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          );
        },
      ),
    );
  }
}
