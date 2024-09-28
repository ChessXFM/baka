import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/features/quiz/bloc/quiz_events.dart';
import 'package:game/features/quiz/bloc/quiz_states.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance
  final List<Quiz> _questions = [
    Quiz(
      question: "What is the capital of Syria?",
      options: ["Damascus", "Aleppo", "Homs", "Latakia"],
      correctAnswer: "Damascus",
    ),
    Quiz(
      question: "How Are You?",
      options: ["Fine", "Good", "Bad", "Mind Your Buiseness !!"],
      correctAnswer: "Mind Your Buiseness !!",
    ),
    Quiz(
      question: "What is the name of the best framework?",
      options: ["Flutter", "lLaravel", "IDK", "WTF!!"],
      correctAnswer: "Flutter",
    ),
    Quiz(
      question: "Random Question ?",
      options: ["yes", "yep", "yeah", "no"],
      correctAnswer: "yep",
    ),
    // Add more questions here
  ];

  QuizBloc() : super(QuizInitial()) {
    on<LoadQuiz>(_onLoadQuiz);
    on<TimerTick>(_onTimerTick);
    on<SelectAnswer>(_onSubmitAnswer);
  }

void _startTimer() {
    const duration = Duration(seconds: 1);
    int timeLeft = 30; // Set the total time for each question

    _timer = Timer.periodic(duration, (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        add(TimerTick(timeLeft)); // Dispatch TimerTick event with the remaining time
      } else {
        _audioPlayer.play(AssetSource('sounds/timer_end.mp3')); // Play timer end sound
        add(SelectAnswer('')); // Automatically submit when time is up
      }
    });
  }


  void _onLoadQuiz(LoadQuiz event, Emitter<QuizState> emit) {
    _startTimer(); // Start timer when quiz is loaded
    emit(QuizLoaded(
      questions: _questions,
      currentQuestionIndex: 0,
      selectedAnswer: '',
      score: 0,
      timeLeft: 30,
      userAnswers: const [], // Initialize userAnswers with an empty list
    ));
  }

  void _onTimerTick(TimerTick event, Emitter<QuizState> emit) {
    final currentState = state as QuizLoaded;
    emit(QuizLoaded(
      questions: currentState.questions,
      currentQuestionIndex: currentState.currentQuestionIndex,
      selectedAnswer: currentState.selectedAnswer,
      score: currentState.score,
      timeLeft: event.timeLeft, // Update time left
      userAnswers: currentState.userAnswers, // Keep track of userAnswers
    ));
  }

  // void _onSubmitAnswer(SelectAnswer event, Emitter<QuizState> emit) {
  //   _timer?.cancel(); // Stop the timer when the answer is submitted
  //   final currentState = state as QuizLoaded;
  //   final question = currentState.questions[currentState.currentQuestionIndex];

  //   int newScore = currentState.score;
  //   if (currentState.selectedAnswer == question.correctAnswer) {
  //     newScore++;
  //   }

  //   // Update the userAnswers list with the latest selected answer
  //   final updatedUserAnswers = [
  //     ...currentState.userAnswers,
  //     currentState.selectedAnswer
  //   ];

  //   if (currentState.currentQuestionIndex + 1 < currentState.questions.length) {
  //     emit(QuizLoaded(
  //       questions: currentState.questions,
  //       currentQuestionIndex: currentState.currentQuestionIndex + 1,
  //       selectedAnswer: '',
  //       score: newScore,
  //       timeLeft: 30, // Reset the timer for the next question
  //       userAnswers: updatedUserAnswers, // Pass updated userAnswers
  //     ));
  //     _startTimer(); // Start a new timer for the next question
  //   } else {
  //     emit(QuizCompleted(
  //       score: newScore,
  //       questions: currentState.questions,
  //       userAnswers:
  //           updatedUserAnswers, // Pass the user's answers to the final state
  //     )); // End of quiz
  //   }
  // }

void _onSubmitAnswer(SelectAnswer event, Emitter<QuizState> emit) {
    _timer?.cancel(); // Stop the timer when the answer is submitted
    final currentState = state as QuizLoaded;
    final question = currentState.questions[currentState.currentQuestionIndex];

    int newScore = currentState.score;
    if (event.selectedAnswer == question.correctAnswer) {
      newScore++;
      _audioPlayer.play(AssetSource('sounds/correct_answer.mp3')); // Play correct answer sound
    } else {
      _audioPlayer.play(AssetSource('sounds/incorrect_answer.mp3')); // Play incorrect answer sound
    }

    // Update the userAnswers list with the latest selected answer
    final updatedUserAnswers = [
      ...currentState.userAnswers,
      event.selectedAnswer
    ];

    if (currentState.currentQuestionIndex + 1 < currentState.questions.length) {
      emit(QuizLoaded(
        questions: currentState.questions,
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
        selectedAnswer: '', // Reset for the next question
        score: newScore,
        timeLeft: 30, // Reset the timer for the next question
        userAnswers: updatedUserAnswers, // Pass updated userAnswers
      ));
      _startTimer(); // Start a new timer for the next question
    } else {
      emit(QuizCompleted(
        score: newScore,
        questions: currentState.questions,
        userAnswers: updatedUserAnswers, // Pass the user's answers to the final state
      )); // End of quiz
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Ensure timer is canceled when the Bloc is closed
    _audioPlayer.dispose(); // Dispose audio player when Bloc is closed
    return super.close();
  }
}
