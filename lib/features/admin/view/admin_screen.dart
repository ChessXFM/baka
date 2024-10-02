// admin_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = '/Admin Panel';
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Questions')),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is QuestionAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Question Added Successfully')));
          } else if (state is QuestionAddFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed: ${state.error}')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
              ),
              ElevatedButton(
                onPressed: () {
                  final questionData = {
                    'question': questionController.text,
                    'answers': [answerController.text],
                    'correctAnswer': answerController.text,
                  };
                  BlocProvider.of<AdminBloc>(context).add(
                    AddQuestionEvent(
                        subject: 'math1', questionData: questionData),
                  );
                },
                child: const Text('Add Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
