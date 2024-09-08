import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/Screens/Home/home_screen.dart';
import 'package:game/features/auth/logic/bloc/auth_bloc.dart';
import 'package:game/features/auth/logic/bloc/auth_event.dart';
import 'package:game/features/auth/logic/bloc/auth_state.dart';
import 'package:game/features/auth/presentation/Signin/signin.dart';
import 'package:game/features/auth/presentation/Signin/widgets/mytextformfield.dart';
import 'package:game/features/auth/presentation/Signin/widgets/password_field.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/sign_up";
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'اسم المستخدم مطلوب';
    } else if (username.length < 3) {
      return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
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

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    } else if (confirmPassword != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  void _onSignUpButtonPressed(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String username = usernameController.text;
    final String confirmPassword = confirmPasswordController.text;

    // Validate fields
    String? emailError = validateEmail(email);
    if (emailError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(emailError)));
      return;
    }

    String? usernameError = validateUsername(username);
    if (usernameError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(usernameError)));
      return;
    }

    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(passwordError)));
      return;
    }

    String? confirmPasswordError = validateConfirmPassword(password, confirmPassword);
    if (confirmPasswordError != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(confirmPasswordError)));
      return;
    }

    // Trigger the sign-up event (modify this part to include the signup logic)
    context.read<AuthBloc>().add(SignUpRequested(username, email, password));
  }

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
                      }
                      return GestureDetector(
                        onTap: () => _onSignUpButtonPressed(context),
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
