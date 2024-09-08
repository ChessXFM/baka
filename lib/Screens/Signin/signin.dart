import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/Screens/Signin/widgets/mytextformfield.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/Sign in";
  SignInScreen({super.key});

  // Controllers for email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle sign-in
  Future<void> signIn(context) async {
    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      // Sign in with email and password using Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // On successful sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully signed in!")),
      );

      // Navigate to another screen (e.g., HomeScreen) upon successful login
      Navigator.pushNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      // Handle errors during sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign-in failed .. Maybe you need VPN")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeHelper.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: ThemeHelper.whiteColor, width: 1.5),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  topLeft: Radius.circular(60)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset.zero,
                  color: ThemeHelper.accentColor,
                  blurRadius: 300,
                  blurStyle: BlurStyle.inner,
                ),
              ],
              color: ThemeHelper.otherprimaryColor.withOpacity(0),
            ),
            width: ScreenSizeHelper.mobileScreenWidth(context) * (80 / 100),
            height: ScreenSizeHelper.mobileScreenHeight(context) / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                // Email input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: myTextFormField(
                    textEditingController: emailController,
                    hintText: "example@gmail.com",
                    lable: 'البريد الالكتروني',
                  ),
                ),
                const SizedBox(height: 15),

                // Password input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: myTextFormField(
                    textEditingController: passwordController,
                    hintText: "كلمة المرور",
                    lable: 'كلمة المرور',
                    obscureText: true,
                    icon: IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed:
                          () {}, // You can implement show/hide password functionality
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Sign-in button
                GestureDetector(
                  onTap: () => signIn(context), // Call signIn function on tap
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: ThemeHelper.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft:  Radius.circular(20),
                            bottomRight:  Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Sign-up prompt
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' قم بالتسجيل الان ',
                      style: TextStyle(
                          fontSize: 16,
                          color: ThemeHelper.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ليس لديك حساب ؟ ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
