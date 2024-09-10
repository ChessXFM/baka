import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/features/auth/logic/bloc/auth_bloc.dart';
import 'package:game/features/auth/logic/bloc/auth_event.dart';

class SignUpFunctions {

  
 static String? validateEmail(String email) {
   final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (email.isEmpty) {
    return 'البريد الإلكتروني مطلوب';
  } else if (!emailRegex.hasMatch(email)) {
    return 'البريد الإلكتروني غير صالح';
  }
  return null;
}

static String? validateUsername(String username) {
  if (username.isEmpty) {
    return 'اسم المستخدم مطلوب';
  } else if (username.length < 3) {
    return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
  }
  return null;
}

static String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'كلمة المرور مطلوبة';
  } else if (password.length < 6) {
    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  }
  return null;
}

static String? validateConfirmPassword(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'تأكيد كلمة المرور مطلوب';
  } else if (confirmPassword != password) {
    return 'كلمة المرور غير متطابقة';
  }
  return null;
}

static void onSignUpButtonPressed(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController usernameController,
    TextEditingController confirmPasswordController) {
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

  String? confirmPasswordError =
      validateConfirmPassword(password, confirmPassword);
  if (confirmPasswordError != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(confirmPasswordError)));
    return;
  }

  // Trigger the sign-up event (modify this part to include the signup logic)
  context.read<AuthBloc>().add(
      SignUpRequested(username: username, email: email, password: password));
}

}