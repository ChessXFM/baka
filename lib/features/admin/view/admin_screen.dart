import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_bloc.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

import '../../quiz/bloc/quiz_events.dart';
import '../../quiz/bloc/quiz_states.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/Admin Panel';
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String? correctAnswer;
  String? selectedSubject;

  // قائمة المواد المتاحة لاختيار المادة المناسبة
  final List<String> subjects = AppConstants.availableSubjectsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuestionAddedSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Question added successfully!')),
            );
            _formKey.currentState
                ?.reset(); // إعادة تعيين الحقول بعد الإضافة الناجحة
            questionController.clear();
            for (var controller in optionControllers) {
              controller.clear();
            }
          } else if (state is QuestionAddedFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Failed to add question: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AddingQuestionState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Dropdown لاختيار المادة
                  DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Select Subject'),
                    value: selectedSubject,
                    items: subjects.map((String subject) {
                      return DropdownMenuItem<String>(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubject = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Text field لإدخال السؤال
                  TextFormField(
                    controller: questionController,
                    decoration:
                        const InputDecoration(labelText: 'Enter question'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a question';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Text fields لإدخال الخيارات
                  ...List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: optionControllers[index],
                        decoration:
                            InputDecoration(labelText: 'Option ${index + 1}'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter option ${index + 1}';
                          }
                          return null;
                        },
                      ),
                    );
                  }),

                  // Dropdown لاختيار الإجابة الصحيحة
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: 'Select Correct Answer'),
                    value: correctAnswer,
                    items: optionControllers.map((controller) {
                      return DropdownMenuItem<String>(
                        value: controller.text,
                        child: Text(controller.text.isNotEmpty
                            ? controller.text
                            : 'Option'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        correctAnswer = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select the correct answer';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // زر لإضافة السؤال
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // إنشاء كائن السؤال
                        final Quiz newQuestion = Quiz(
                          id: '', // سيتم توليده لاحقًا
                          question: questionController.text,
                          options: optionControllers
                              .map((controller) => controller.text)
                              .toList(),
                          correctAnswer: correctAnswer!,
                        );

                        // تحفيز حدث إضافة السؤال
                        context.read<QuizBloc>().add(AddQuestionEvent(
                              subject: selectedSubject!,
                              question: newQuestion,
                            ));
                      }
                    },
                    child: const Text('Add Question'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
