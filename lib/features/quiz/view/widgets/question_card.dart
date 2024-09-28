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
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style:const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ...options.map((option) => GestureDetector(
                  onTap: () => onSelect(option),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: selectedAnswer == option
                          ? Colors.blueAccent.withOpacity(0.7)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selectedAnswer == option
                            ? Colors.blueAccent
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: option,
                          groupValue: selectedAnswer,
                          onChanged: onSelect,
                          activeColor: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            option,
                            style:const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
