import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.controller,
    this.initialValue,
    this.decoration,
    this.keyboardType,
    this.obscureText=false,
    this.autofillHints,
    this.validator,
    this.style=const TextStyle(
      color: Colors.indigoAccent,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    this.onChanged,
    this.onTap,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? initialValue;
  final InputDecoration? decoration;
  final TextStyle style;
  final TextInputType? keyboardType;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final FormFieldValidator? validator;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: decoration,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autofillHints: autofillHints,
      validator: validator,
      style: style,
      onTap: onTap,
      onChanged: onChanged,
      maxLength: maxLength,
    );
  }
}
