import 'package:ecommercestore/services/auth.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Sign in',
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextFormField(
                    autofillHints: const [AutofillHints.email],
                    controller: fieldText,
                    decoration: MyInputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          clearText();
                        },
                      ),
                      labelText: "Email",
                    ),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (email) {
                      !EmailValidator.validate(email ?? '')
                          ? 'Enter valid email'
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
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
                                var result = await _auth.resetPassword(email);
                              } catch (error) {
                                print(error.toString());
                                return;
                              }
                              Navigator.pop(context);
                            }
                          }
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }
}
