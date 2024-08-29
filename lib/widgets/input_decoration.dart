import 'package:flutter/material.dart';

class MyInputDecoration extends InputDecoration {
  const MyInputDecoration({
    Widget? label,
    Icon? icon,
    String? labelText,
    TextStyle? labelStyle = const TextStyle(
      fontSize: 18,
      color: Colors.grey,
      fontWeight: FontWeight.w400,
    ),
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputBorder border=InputBorder.none,
  }) : super(
          label: label,
          icon: icon,
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
}
