import 'package:flutter/material.dart';
import 'package:game/Core/theme_helper.dart';

import '../../Core/constant.dart';
import '../Signin/widgets/mytextformfield.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/Sign up";
  SignUpScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeHelper.primaryColor,
        appBar: AppBar(
          title: const Center(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: (Text(
                'التسجيل في التطبيق',
              )),
            ),
          ),
          toolbarHeight: 35,
          backgroundColor: ThemeHelper.accentColor,
          shadowColor: Colors.white,
        ),
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
          height: ScreenSizeHelper.mobileScreenHeight(context) / 1.6,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(hintText: "الاسم", lable: 'اسمك :', textEditingController: usernameController,),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(textEditingController: emailController,
                        hintText: "example@gmail.com",
                        lable: 'البريد الالكتروني'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(textEditingController: passwordController,
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
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: myTextFormField(
                        hintText: "تأكيد كلمة المرور",
                        lable: 'تأكيد كلمة المرور',
                        obscureText: true,
                        icon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              //signupr button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'تسجيل',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
