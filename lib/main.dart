import 'package:flutter/material.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/Screens/Signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
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
        HomeScreen.routeName:(context) => const HomeScreen(),
      },
    );
  }
}
