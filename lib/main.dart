import 'package:flutter/material.dart';
import 'package:game/Screens/Home/home_screen.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SignInScreen(),
      routes: {
        SignInScreen.routeName: (context) =>  SignInScreen(),
        SignUpScreen.routeName: (context) =>  SignUpScreen(),
        HomeScreen.routeName:(context) => const HomeScreen(),
      },
    );
  }
}
