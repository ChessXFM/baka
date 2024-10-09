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

class UnlockSubject extends QuizEvent {
  final String subjectName;

  const UnlockSubject(this.subjectName);

  @override
  List<Object> get props => [subjectName];
}