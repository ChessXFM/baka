abstract class QuizEvent {}

class LoadQuiz extends QuizEvent {
  final String subject;

  LoadQuiz(this.subject);
}

class SelectAnswer extends QuizEvent {
  final String selectedAnswer;

  SelectAnswer(this.selectedAnswer);
}

class StartTimer extends QuizEvent {}

class TimerTick extends QuizEvent {
  final int timeLeft;

  TimerTick(this.timeLeft);
}

class SyncQuestions extends QuizEvent {
  final String subject;

  SyncQuestions(this.subject);
}

