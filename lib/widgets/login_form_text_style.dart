import 'package:flutter/material.dart';

class LoginFormTextStyle extends TextStyle {
  const LoginFormTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
  }) : super(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.normal,
        );
}
