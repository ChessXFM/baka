import 'package:flutter/material.dart';

Widget myTextFormField(
    {required String hintText,
    String? lable,
    bool? obscureText,
    Widget? icon,TextEditingController? textEditingController}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: TextFormField(
      controller: textEditingController,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          prefixIcon: icon,
          border: InputBorder.none,
          hintText: hintText,
          label: Text(lable ?? ""),
          alignLabelWithHint: true),
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
