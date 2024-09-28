abstract class QuizEvent {}

class LoadQuiz extends QuizEvent {}

class SelectAnswer extends QuizEvent {
  final String selectedAnswer;

  SelectAnswer(this.selectedAnswer);
}

class StartTimer extends QuizEvent {}

class TimerTick extends QuizEvent {
  final int timeLeft;

  TimerTick(this.timeLeft);
}
