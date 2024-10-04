import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/features/quiz/bloc/quiz_events.dart';
import 'package:game/features/quiz/bloc/quiz_states.dart';
import '../../../Core/constant.dart';
import '../services/firebase_service.dart';
import '../services/local_storage_service.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance
  final LocalStorageService localStorageService = LocalStorageService();
  final FirebaseService firebaseService = FirebaseService();

  QuizBloc() : super(QuizInitialState()) {
    on<LoadQuiz>(_onLoadQuiz);
    on<TimerTick>(_onTimerTick);
    on<SelectAnswer>(_onSubmitAnswer);
    on<SyncQuestions>(_onSyncQuestions);
    on<AddQuestionEvent>(_onAddQuestion);
  }

  void _startTimer() {
    const duration = Duration(seconds: 1);
    int timeLeft = 30; // Set the total time for each question

    _timer = Timer.periodic(duration, (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        add(TimerTick(
            timeLeft)); // Dispatch TimerTick event with the remaining time
      } else {
        _audioPlayer.play(
          AssetSource('sounds/timer_end.mp3'),
        ); // Play timer end sound
        add(SelectAnswer('')); // Automatically submit when time is up
      }
    });
  }

  void _onLoadQuiz(LoadQuiz event, Emitter<QuizState> emit) async {
    final sharedQuestions =
        await localStorageService.loadQuestions(event.subject);
    if (sharedQuestions.isEmpty) {
      _startTimer(); // Start timer when quiz is loaded
      emit(QuizLoadedState(
        questions: AppConstants.staticQuestions,
        currentQuestionIndex: 0,
        selectedAnswer: '',
        score: 0,
        timeLeft: 30,
        userAnswers: const [], // Initialize userAnswers with an empty list
      ));
    } else {
      _startTimer(); // Start timer when quiz is loaded
      emit(QuizLoadedState(
        questions: sharedQuestions,
        currentQuestionIndex: 0,
        selectedAnswer: '',
        score: 0,
        timeLeft: 30,
        userAnswers: const [], // Initialize userAnswers with an empty list
      ));
    }
  }

  void _onTimerTick(TimerTick event, Emitter<QuizState> emit) {
    final currentState = state as QuizLoadedState;
    emit(QuizLoadedState(
      questions: currentState.questions,
      currentQuestionIndex: currentState.currentQuestionIndex,
      selectedAnswer: currentState.selectedAnswer,
      score: currentState.score,
      timeLeft: event.timeLeft, // Update time left
      userAnswers: currentState.userAnswers, // Keep track of userAnswers
    ));
  }

  void _onSubmitAnswer(SelectAnswer event, Emitter<QuizState> emit) {
    _timer?.cancel(); // Stop the timer when the answer is submitted
    final currentState = state as QuizLoadedState;
    final question = currentState.questions[currentState.currentQuestionIndex];

    int newScore = currentState.score;
    if (event.selectedAnswer == question.correctAnswer) {
      newScore++;
      _audioPlayer.play(
          AssetSource('sounds/wrong_answer.mp3')); // Play correct answer sound
    } else {
      _audioPlayer.play(AssetSource(
          'sounds/wrong_answer.mp3')); // Play incorrect answer sound
    }

    // Update the userAnswers list with the latest selected answer
    final updatedUserAnswers = [
      ...currentState.userAnswers,
      event.selectedAnswer
    ];

    if (currentState.currentQuestionIndex + 1 < currentState.questions.length) {
      emit(QuizLoadedState(
        questions: currentState.questions,
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
        selectedAnswer: '', // Reset for the next question
        score: newScore,
        timeLeft: 30, // Reset the timer for the next question
        userAnswers: updatedUserAnswers, // Pass updated userAnswers
      ));
      _startTimer(); // Start a new timer for the next question
    } else {
      emit(QuizCompletedState(
        score: newScore,
        questions: currentState.questions,
        userAnswers:
            updatedUserAnswers, // Pass the user's answers to the final state
      )); // End of quiz
    }
  }

  void _onSyncQuestions(SyncQuestions event, Emitter<QuizState> emit) async {
    emit(QuizLoadingState());

    try {
      // Fetch new questions from Firebase
      final newQuestions =
          await firebaseService.fetchNewQuestions(event.subject);

      // Load existing questions from local storage
      final existingQuestions =
          await localStorageService.loadQuestions(event.subject);

      // Merge existing and new questions
      final allQuestions = [
        ...existingQuestions,
        ...newQuestions.where((newQuestion) => !existingQuestions
            .any((existingQuestion) => existingQuestion.id == newQuestion.id)),
      ];

      // Save merged questions to local storage
      await localStorageService.saveQuestions(event.subject, allQuestions);

      // Emit the loaded state
      emit(QuizLoadedState(
        questions: allQuestions,
        currentQuestionIndex: 0,
        selectedAnswer: '',
        score: 0,
        timeLeft: 30, // example timer
        userAnswers: const [],
      ));
    } on FirebaseException catch (e) {
      // Emit a specific error state for Firebase issues
      emit(QuizErrorState(error: "Firebase error: ${e.message}"));
    } catch (error) {
      // Emit a general error state for other issues
      emit(QuizErrorState(error: "An unexpected error occurred: $error"));
    }
  }

// Handler for adding a question to Firebase
  Future<void> _onAddQuestion(
      AddQuestionEvent event, Emitter<QuizState> emit) async {
    emit(AddingQuestionState());

    try {
      // Call the Firebase service to add the question
      await firebaseService.addQuestion(event.subject, event.question);

      // Emit success state if the question is added successfully
      emit(QuestionAddedSuccessState());
    } catch (e) {
      // Emit failure state if an error occurs
      emit(QuestionAddedFailureState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Ensure timer is canceled when the Bloc is closed
    _audioPlayer.dispose(); // Dispose audio player when Bloc is closed
    return super.close();
  }
}
