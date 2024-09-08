import 'package:flutter/material.dart';
import 'package:game/Core/theme_helper.dart';

Widget myTextFormField(
    {required String hintText,
    String? lable,
    bool? obscureText,
    Widget? icon,
    TextEditingController? textEditingController}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: TextFormField(
      controller: textEditingController,
      obscureText: obscureText ?? false,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        // iconColor: Colors.white,
        // focusColor: Colors.white,
        //   fillColor: Colors.white,
        iconColor: ThemeHelper.primaryColor,
        suffixIconColor: ThemeHelper.primaryColor,
        enabledBorder: UnderlineInputBorder(),
        floatingLabelStyle: TextStyle(color: ThemeHelper.primaryColor),
        focusedBorder: UnderlineInputBorder(),
        errorBorder: UnderlineInputBorder(),
        disabledBorder: UnderlineInputBorder(),
        focusedErrorBorder: UnderlineInputBorder(),
        // prefixIcon: icon,
        suffixIcon: icon,
        border: InputBorder.none,
        hintText: hintText,
        // label: Text(lable ?? ""),
        labelText: lable,
        labelStyle: const TextStyle(color: Colors.black),
        // floatingLabelAlignment: FloatingLabelAlignment.start,
        // fillColor: Colors.grey,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        //alignLabelWithHint: true
      ),
    ),
  );
}

// class MyTextFormFieldWidget extends StatefulWidget {
//   const MyTextFormFieldWidget(
//       {super.key,
//       required this.hintText,
//       this.lable,
//       this.obscureText,
//       this.icon});
//   final String hintText;
//   final String? lable;
//   final bool? obscureText;
//   final Widget? icon;
//   @override
//   State<MyTextFormFieldWidget> createState() => _MyTextFormFieldWidgetState();
// }

// class _MyTextFormFieldWidgetState extends State<MyTextFormFieldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: TextFormField(
//         obscureText: obscureText ?? false,
//         decoration: InputDecoration(
//             prefixIcon: icon,
//             border: InputBorder.none,
//             hintText: hintText,
//             label: Text(lable ?? ""),
//             alignLabelWithHint: true),
//       ),
//     );
//   }
// }
