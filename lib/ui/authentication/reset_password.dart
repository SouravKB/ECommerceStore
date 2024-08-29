import 'package:ecommercestore/services/auth_service.dart';
import 'package:ecommercestore/util/toast.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/login_form_hint_text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Reset password',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailTextController,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => _emailTextController.clear(),
                      ),
                      labelText: "Email",
                      labelStyle: const LoginFormHintTextStyle(),
                    ),
                    onChanged: (val) {
                      setState(() => _email = val);
                    },
                    validator: (email) {
                      !EmailValidator.validate(email ?? '')
                          ? 'Enter valid email'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await AuthService.instance
                                .resetPasswordWithEmail(_email);
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (error) {
                            _handleResetPasswordError(error.code);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleResetPasswordError(String errorCode) {
    switch (errorCode) {
      default:
        showToast(context, "Password reset failed, please try again later");
    }
  }
}
