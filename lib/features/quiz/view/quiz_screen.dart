import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_states.dart';
import 'package:game/features/quiz/view/review_screen.dart';
import 'package:game/features/quiz/view/widgets/question_card.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_events.dart';

class QuizScreen extends StatelessWidget {
  static const String routeName = '/Tests Screen';
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QuizBloc>().add(LoadQuiz());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text(AppConstants.quizTitle)),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if (state is QuizInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
              
                if (state is QuizLoaded) {
                  return QuestionCard(
                    question: state.questions[state.currentQuestionIndex].question,
                    options: state.questions[state.currentQuestionIndex].options,
                    selectedAnswer: state.selectedAnswer,
                    onSelect: (value) {
                      context.read<QuizBloc>().add(SelectAnswer(value!));
            
                    },
                  );
                }
              
                if (state is QuizCompleted) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Quiz Completed! Your Score: ${state.score}"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewScreen(
                                  questions: state.questions,
                                  userAnswers: state.userAnswers,
                                ),
                              ),
                            );
                          },
                          child: const Text("Review Answers"),
                        ),
                      ],
                    ),
                  );
                }
              
                return const Center(child: Text('An error occurred!'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
