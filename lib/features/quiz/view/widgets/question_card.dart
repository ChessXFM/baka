import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final String selectedAnswer;
  final void Function(String?) onSelect;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedAnswer,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question),
        ...options.map((option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: selectedAnswer,
              onChanged: onSelect,
            )),
      ],
    );
  }
}
