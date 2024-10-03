import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/Home/home_screen.dart';
import 'package:game/features/auth/bloc/auth_bloc.dart';
import 'package:game/features/auth/bloc/auth_state.dart';
import 'package:game/features/auth/view/Signin/signin.dart';
import 'package:game/features/auth/view/Signin/widgets/mytextformfield.dart';
import 'package:game/features/auth/view/Signin/widgets/password_field.dart';
import 'package:game/features/auth/view/Signup/signup_functions.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/sign_up";
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              height: (ScreenSizeHelper.mobileScreenHeight(context)) * 80 / 100,
              width: (ScreenSizeHelper.mobileScreenWidth(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Username input field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(
                      textEditingController: usernameController,
                      hintText: "اسم المستخدم",
                      lable: 'اسم المستخدم',
                    ),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  // Confirm Password input field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: PasswordField(
                      controller: confirmPasswordController,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Sign-up button with BlocBuilder
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is Authenticated) {
                        return const Icon(Icons.done_all);
                      }
                      return GestureDetector(
                        onTap: () => SignUpFunctions.onSignUpButtonPressed(
                            context,
                            emailController,
                            passwordController,
                            usernameController,
                            confirmPasswordController),
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
                                'إنشاء حساب',
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
                  const SizedBox(height: 40),
                  // Sign-in prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        child: const Text(
                          ' سجل الدخول الان ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'لديك حساب بالفعل؟ ',
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
