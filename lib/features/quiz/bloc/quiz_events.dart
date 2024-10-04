import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class LoadQuiz extends QuizEvent {
  final String subject;

  const LoadQuiz(this.subject);
  @override
  List<Object> get props => [subject];
}

class SelectAnswer extends QuizEvent {
  final String selectedAnswer;

  const SelectAnswer(this.selectedAnswer);
  @override
  List<Object> get props => [selectedAnswer];
}

class StartTimer extends QuizEvent {}

class TimerTick extends QuizEvent {
  final int timeLeft;

  const TimerTick(this.timeLeft);
  @override
  List<Object> get props => [timeLeft];
}

class SyncQuestions extends QuizEvent {
  final String subject;

  const SyncQuestions(this.subject);
  @override
  List<Object> get props => [subject];
}

// // Event for adding a single question
// class AddQuestionEvent extends QuizEvent {
//   final String subject;
//   final Quiz question;

//   const AddQuestionEvent({required this.subject, required this.question});

//   @override
//   List<Object> get props => [subject, question];
// }
