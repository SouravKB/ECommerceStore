import 'package:flutter/material.dart';

class PrintTextStyle extends TextStyle {
  const PrintTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
  }) : super(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.normal,
        );
}
