import 'package:equatable/equatable.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitialState extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {
  final List<Quiz> questions;
  final int currentQuestionIndex;
  final String selectedAnswer;
  final int score;
  final int timeLeft;
  final List<String> userAnswers;

  const QuizLoadedState({
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

class QuizCompletedState extends QuizState {
  final int score;
  final List<Quiz> questions;
  final List<String> userAnswers;

  const QuizCompletedState({
    required this.score,
    required this.questions,
    required this.userAnswers,
  });

  @override
  List<Object> get props => [score, questions, userAnswers];
}

class QuizErrorState extends QuizState {
  final String error;
  const QuizErrorState({
    required this.error,
  });
}

// State when adding question is in progress
class AddingQuestionState extends QuizState {}

// State when adding question is successful
class QuestionAddedSuccessState extends QuizState {}

// State when adding question fails
class QuestionAddedFailureState extends QuizState {
  final String errorMessage;

  const QuestionAddedFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
