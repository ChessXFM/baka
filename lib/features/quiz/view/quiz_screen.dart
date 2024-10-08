import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/features/quiz/bloc/quiz_states.dart';
import 'package:game/features/quiz/view/review_screen.dart';
import 'package:game/features/quiz/view/widgets/question_card.dart';
import 'package:lottie/lottie.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_events.dart';

class QuizScreen extends StatefulWidget {
  static const String routeName = '/Quizes Screen';
  const QuizScreen({super.key, required this.subject});

  final String subject;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // late Timer _timer;
  QuizBloc? _quizBloc; // Store the QuizBloc instance

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_quizBloc == null) {
      _quizBloc = context.read<QuizBloc>(); // Safely initialize the QuizBloc
      _quizBloc!.add(LoadQuiz(widget.subject));
      print("Loading quiz for subject: ${widget.subject}");
    }
  }

  @override
  void dispose() {
    // _quizBloc?.close(); // Safely close the QuizBloc
    super.dispose();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // Load the quiz when the screen is built
  //   context.read<QuizBloc>().add(LoadQuiz(widget.subject));
  //   print("Loading quiz for subject: ${widget.subject}");

  //   // Initialize your timer or any other resource here if necessary
  //   // _startTimer();
  // }

  // void _startTimer() {
  //   // Example: Start a timer for the quiz duration
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     // Your timer logic here
  //   });
  // }

  // @override
  // void dispose() {
  //   // Stop the timer when the user navigates away from this screen
  //   context.read<QuizBloc>().close();
  //   // _timer.cancel();
  //   super.dispose();
  // }

  Future<bool> _onWillPop() async {
    // Perform any cleanup if necessary here
    // _timer.cancel(); // Optionally cancel timer if navigating back
    // context.read<QuizBloc>().close();
    // super.dispose();

    return false; // Deny back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(AppConstants.quizTitle),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset(
                  'assets/lottie/infinity.json',
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
                  if (state is QuizInitialState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is QuizLoadedState) {
                    return Column(
                      children: [
                        _buildTimer(state.timeLeft),
                        QuestionCard(
                          question: state
                              .questions[state.currentQuestionIndex].question,
                          options: state
                              .questions[state.currentQuestionIndex].options,
                          selectedAnswer: state.selectedAnswer,
                          onSelect: (value) {
                            context.read<QuizBloc>().add(SelectAnswer(value!));
                          },
                        ),
                      ],
                    );
                  }

                  if (state is QuizCompletedState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text("انتهى الاختبار! نتيجتك هي: ${state.score}"),
                          ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ThemeHelper.otherprimaryColor)),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                    questions: state.questions,
                                    userAnswers: state.userAnswers,
                                  ),
                                ),
                              );
                            },
                            child: const Text("مراجعة الإجابات"),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(child: Text('حدث خطأ ما ؟؟'));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimer(int timeLeft) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: timeLeft / 30, // Assuming a total of 30 seconds
            backgroundColor: Colors.white,
            color: ThemeHelper.otherprimaryColor,
            strokeWidth: 8,
          ),
          const SizedBox(width: 20),
          Text(
            '$timeLeft',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
