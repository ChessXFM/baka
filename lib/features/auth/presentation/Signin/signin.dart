import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/features/auth/logic/bloc/auth_bloc.dart';
import 'package:game/features/auth/logic/bloc/auth_event.dart';
import 'package:game/features/auth/logic/bloc/auth_state.dart';
import 'package:game/features/auth/presentation/Signin/widgets/mytextformfield.dart';
import 'package:game/features/auth/presentation/Signin/widgets/password_field.dart';
import 'package:game/features/auth/presentation/Signup/signup.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/sign_in";
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    } else if (!emailRegex.hasMatch(email)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    } else if (password.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  void _onSignInButtonPressed(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Validate email and password
    String? emailError = validateEmail(email);
    if (emailError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(emailError)));
      return;
    }

    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(passwordError)));
      return;
    }

    // Trigger the sign-in event
    context.read<AuthBloc>().add(SignInRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: ThemeHelper.primaryColor,
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background.jpg'))),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                // Navigate to HomeScreen
                Navigator.pushNamed(context, HomeScreen.routeName);
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70)),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 400,
                        blurStyle: BlurStyle.inner,
                        color: Colors.white)
                  ]),
              height: (ScreenSizeHelper.mobileScreenHeight(context)) * 70 / 100,
              width: (ScreenSizeHelper.mobileScreenWidth(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Email input field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(
                      textEditingController: emailController,
                      hintText: "example@gmail.com",
                      lable: 'البريد الإلكتروني',
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Password input field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: PasswordField(
                      controller: passwordController,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Sign-in button with BlocBuilder
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return GestureDetector(
                        onTap: () => _onSignInButtonPressed(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            child: const Center(
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                  // Sign-up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          ' قم بالتسجيل الان ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'ليس لديك حساب ؟ ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
