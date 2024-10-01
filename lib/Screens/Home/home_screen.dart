import 'package:flutter/material.dart';
import 'package:game/Core/theme_helper.dart';

import '../../features/auth/view/Signin/signin.dart';
import '../../features/auth/view/Signup/signup.dart';
import '../../features/quiz/view/quiz_screen.dart';
import '../../features/study table/view/lottie_test.dart';
import '../../features/study table/view/study_final.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // رسالة ترحيبية
            const Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // أيقونات للتنقل بين الشاشات
            Wrap(
              spacing: 20, // المسافة بين الأيقونات
              runSpacing: 20, // المسافة بين الصفوف
              alignment: WrapAlignment.center,
              children: [
                // أيقونة Quiz Screen
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, QuizScreen.routeName),
                  icon: const Icon(Icons.psychology_alt),
                  color: ThemeHelper.primaryColor,
                  iconSize: 60,
                ),
                // أيقونة Study Table Final
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, StudyTableFinal.routeName),
                  icon: const Icon(Icons.table_chart),
                  color: Colors.green,
                  iconSize: 60,
                ),
                // أيقونة Sign In Screen
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignInScreen.routeName),
                  icon: const Icon(Icons.login),
                  color: Colors.blue,
                  iconSize: 60,
                ),
                // أيقونة Sign Up Screen
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignUpScreen.routeName),
                  icon: const Icon(Icons.app_registration),
                  color: Colors.orange,
                  iconSize: 60,
                ),
                // أيقونة Test Lottie Animation
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, TestLottie.routeName),
                  icon: const Icon(Icons.animation),
                  color: Colors.purple,
                  iconSize: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
