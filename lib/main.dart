import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/features/auth/model/repositories/auth_repository.dart';
import 'package:game/features/auth/bloc/auth_bloc.dart';
import 'package:game/features/auth/view/Signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:game/features/quiz/bloc/quiz_bloc.dart';
import 'package:game/features/study%20table/view/study_table.dart';
import 'package:game/features/study%20table/view/study_table_f.dart';
import 'package:game/features/quiz/view/quiz_screen.dart';
import 'features/auth/view/Signup/signup.dart';
import 'firebase_options.dart';

// ...

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          routes: {
            QuizScreen.routeName: (context) => QuizScreen(),
            SignInScreen.routeName: (context) => SignInScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            StudyTable.routeName: (context) => StudyTable(),
            StudyTableF.routeName: (context) => const StudyTableF(),
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
