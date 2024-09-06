import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth
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
  Future<void> signIn( context) async {
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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  blurStyle: BlurStyle.inner,
                ),
              ],
              color: ThemeHelper.otherprimaryColor.withOpacity(0.7)),
          width: ScreenSizeHelper.mobileScreenWidth(context) * (80 / 100),
          height: ScreenSizeHelper.mobileScreenHeight(context) / 2,
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Email input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(
                      textEditingController: emailController,
                      hintText: "example@gmail.com",
                      lable: 'البريد الالكتروني',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(
                      textEditingController: passwordController,
                      hintText: "كلمة المرور",
                      lable: 'كلمة المرور',
                      obscureText: true,
                      icon: IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        onPressed: () {}, // You can implement show/hide password functionality
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Sign-in button
              GestureDetector(
                onTap: () => signIn(context),  // Call signIn function on tap
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
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
              const SizedBox(height: 20),

              // Sign-up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' قم بالتسجيل الان ',
                    style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'هل لديك حساب ؟ ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
