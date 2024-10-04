import 'package:flutter/material.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/features/Home/widgets/feature_card_widget.dart';
import 'package:game/features/Home/widgets/my_drawer_widget.dart';
import 'package:game/features/quiz/view/subjetcs_screen.dart';
import '../admin/view/admin_screen.dart';
import '../auth/view/Signin/signin.dart';
import '../auth/view/Signup/signup.dart';
import '../study table/view/lottie_test.dart';
import '../study table/view/study_final.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ThemeHelper.primaryColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        centerTitle: true,
        // backgroundColor: ThemeHelper.otherprimaryColor,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Message
            const Text(
              'مرحبا بك !',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 32,
                // fontWeight: FontWeight.bold,
                // color: Color.fromARGB(221, 255, 255, 255),
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Modern Card-based icons grid with animation
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two cards per row
                crossAxisSpacing: 5, // Space between columns
                mainAxisSpacing: 5, // Space between rows
                children: [
                  FeatureCard(
                    icon: Icons.psychology_alt,
                    label: 'اختبر نفسك',
                    color: ThemeHelper.primaryColor,
                    onTap: () => Navigator.pushNamed(
                        context, SubjectSelectionScreen.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.table_chart,
                    label: 'جدول الدراسة',
                    color: Colors.green,
                    onTap: () =>
                        Navigator.pushNamed(context, StudyTableFinal.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.login,
                    label: "تسجيل الدخول",
                    color: Colors.blue,
                    onTap: () =>
                        Navigator.pushNamed(context, SignInScreen.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.app_registration,
                    label: 'التسجيل',
                    color: Colors.orange,
                    onTap: () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.animation,
                    label: 'Test Animation',
                    color: Colors.purple,
                    onTap: () =>
                        Navigator.pushNamed(context, TestLottie.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.admin_panel_settings,
                    label: 'Admin Panel',
                    color: const Color.fromARGB(255, 30, 12, 143),
                    onTap: () =>
                        Navigator.pushNamed(context, AdminScreen.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.admin_panel_settings,
                    label: 'Admin Panel',
                    color: const Color.fromARGB(255, 30, 12, 143),
                    onTap: () =>
                        Navigator.pushNamed(context, AdminScreen.routeName),
                  ),
                  FeatureCard(
                    icon: Icons.admin_panel_settings,
                    label: 'Admin Panel',
                    color: const Color.fromARGB(255, 30, 12, 143),
                    onTap: () =>
                        Navigator.pushNamed(context, AdminScreen.routeName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
