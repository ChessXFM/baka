import 'package:flutter/material.dart';
import 'package:game/Core/constant.dart';
import 'package:game/Core/theme_helper.dart';
import 'package:game/Screens/Signin/widgets/mytextformfield.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/Sign in";
  const SignInScreen({super.key});

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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Text(
              //   'تسجيل الدخول',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 20),
              //Email textField
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
                        hintText: "example@gmail.com",
                        lable: 'البريد الالكتروني'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //password textField
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
                        hintText: "كلمة المرور",
                        lable: 'كلمة المرور',
                        obscureText: true,
                        icon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //signin button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
