import 'package:equatable/equatable.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Quiz> questions;
  final int currentQuestionIndex;
  final String selectedAnswer;
  final int score;
  final int timeLeft;
  final List<String> userAnswers;

  const QuizLoaded({
    required this.questions,
    required this.currentQuestionIndex,
    required this.selectedAnswer,
    required this.score,
    required this.timeLeft,
    required this.userAnswers, // Add userAnswers here
  });

  @override
  List<Object> get props => [
        questions,
        currentQuestionIndex,
        selectedAnswer,
        score,
        timeLeft,
        userAnswers,
      ];
}

class QuizCompleted extends QuizState {
  final int score;
  final List<Quiz> questions;
  final List<String> userAnswers;

  const QuizCompleted({
    required this.score,
    required this.questions,
    required this.userAnswers,
  });

  @override
  List<Object> get props => [score, questions, userAnswers];
}
