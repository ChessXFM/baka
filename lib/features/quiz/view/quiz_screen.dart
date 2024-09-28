import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_states.dart';
import 'package:game/features/quiz/view/review_screen.dart';
import 'package:game/features/quiz/view/widgets/question_card.dart';
import 'package:lottie/lottie.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
              if (state is QuizInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is QuizLoaded) {
                return Column(
                  children: [
                    _buildTimer(state.timeLeft), // Modern Timer Layout
                    const SizedBox(height: 10,),
                    Lottie.asset('assets/lottie/your_animation_file.json', width: 100, height: 100),
                    const SizedBox(height: 10,),
                    QuestionCard(
                      question: state.questions[state.currentQuestionIndex].question,
                      options: state.questions[state.currentQuestionIndex].options,
                      selectedAnswer: state.selectedAnswer,
                      onSelect: (value) {
                        context.read<QuizBloc>().add(SelectAnswer(value!));
                      },
                    ),
                  ],
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
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer(int timeLeft) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular progress indicator for visual effect
          CircularProgressIndicator(
            value: timeLeft / 30, // Assuming a total of 30 seconds
            backgroundColor: Colors.grey[300],
            color: Colors.blueAccent,
            strokeWidth: 8,
          ),
          const SizedBox(width: 20),
          // Timer text display
          Text(
            '$timeLeft',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
