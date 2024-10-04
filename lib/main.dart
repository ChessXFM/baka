import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/features/Home/home_screen.dart';
import 'package:game/features/auth/model/repositories/auth_repository.dart';
import 'package:game/features/auth/bloc/auth_bloc.dart';
import 'package:game/features/auth/view/Signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:game/features/quiz/bloc/quiz_bloc.dart';
import 'package:game/features/quiz/view/quiz_screen.dart';
import 'package:game/features/quiz/view/subjetcs_screen.dart';
import 'package:game/features/study%20table/view/lottie_test.dart';
import 'features/admin/bloc/admin_bloc.dart';
import 'features/admin/view/admin_screen.dart';
import 'features/auth/view/Signup/signup.dart';
import 'features/study table/view/study_final.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// ...

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the timezone package
  tz.initializeTimeZones();
  // Set the appropriate timezone
  // Initialization settings for Android and iOS
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthRepository authRepository = AuthRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: authRepository, firestore: firestore),
          ),
          BlocProvider(
            create: (context) => QuizBloc(),
          ),
          BlocProvider(
            create: (context) => AdminBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          theme: ThemeData(
            scaffoldBackgroundColor: ThemeHelper.accentColor,
            appBarTheme: AppBarTheme(color: ThemeHelper.otherprimaryColor),
            brightness: Brightness.light,
            fontFamily: 'Amiri',
            primaryColor: ThemeHelper.otherprimaryColor,
            primaryColorDark: ThemeHelper.otherprimaryColor,
          ),
          routes: {
            SubjectSelectionScreen.routeName: (context) =>
                SubjectSelectionScreen(),
            QuizScreen.routeName: (context) => QuizScreen(
                  subject: ModalRoute.of(context)!.settings.arguments as String,
                ),
            TestLottie.routeName: (context) => const TestLottie(),
            SignInScreen.routeName: (context) => SignInScreen(),
            AdminScreen.routeName: (context) => AdminScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            StudyTableFinal.routeName: (context) => const StudyTableFinal(),
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
