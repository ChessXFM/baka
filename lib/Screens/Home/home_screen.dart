import 'package:flutter/material.dart';
import 'package:game/Core/theme_helper.dart';

import '../../features/quiz/view/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Logged In !\nGo To Quizes Now',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 40),
            IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, QuizScreen.routeName, (route) => false),
                icon: const Icon(Icons.psychology_alt),
                color: ThemeHelper.primaryColor,
                iconSize: 100),
          ],
        ),
      ),
    );
  }
}
