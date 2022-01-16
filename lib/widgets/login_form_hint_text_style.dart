import 'package:flutter/material.dart';

class LoginFormHintTextStyle extends TextStyle {
  const LoginFormHintTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
  }) : super(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: Colors.grey,
        );
}
