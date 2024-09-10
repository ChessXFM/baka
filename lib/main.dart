import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/features/auth/data/repositories/auth_repository.dart';
import 'package:game/features/auth/logic/bloc/auth_bloc.dart';
import 'package:game/features/auth/presentation/Signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/presentation/Signup/signup.dart';
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
      child: BlocProvider(
        create: (context) =>
            AuthBloc(authRepository: authRepository, firestore: firestore),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SignInScreen(),
          routes: {
            SignInScreen.routeName: (context) => SignInScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
