// password_field.dart

import 'package:flutter/material.dart';
import 'package:game/features/auth/view/Signin/widgets/mytextformfield.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return myTextFormField(
      textEditingController: widget.controller,
      hintText: "كلمة المرور",
      lable: 'كلمة المرور',
      obscureText: !_isPasswordVisible,
      icon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
    );
  }
}
