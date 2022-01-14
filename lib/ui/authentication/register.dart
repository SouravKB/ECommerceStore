import 'dart:developer';

import 'package:ecommercestore/services/auth.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function togScreen;

  const Register({Key? key, required this.togScreen}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email='';
  String password = '';
  String confirmPassword='';
  String? name ;
  String phoneNo='';
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Register',
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Create account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Create new account to continue",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        labelText: "Name",
                      ),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      maxLength: 40,
                      validator: (name) {
                        if(name.toString().isEmpty) {
                          return 'enter the name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    MyTextFormField(
                      controller: fieldText,
                      autofillHints: const [AutofillHints.email],
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
                        if(email.length==0){
                          return 'Please enter the email id';
                        }
                        else if(!EmailValidator.validate(email)){
                          return 'Please enter a valid email id';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      decoration: const MyInputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 30,
                        ),
                        labelText: "Phone Number",
                      ),
                      onChanged: (val) {
                        setState(() {
                          phoneNo = val;
                        });
                      },
                      validator: (value){
                        String pattern = r'^(?:[+0]9)?[0-9]{10}$';
                        RegExp regExp = RegExp(pattern);
                        if (value.length == 0) {
                          return 'Please enter mobile number';
                        }
                        else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      obscureText: _passwordObscureText,
                      decoration: MyInputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 30,
                        ),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (value) {
                        if(value.length<8){
                          return 'enter minimum 8 characters';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      obscureText: _confirmPasswordObscureText,
                      decoration: MyInputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 30,
                        ),
                        labelText: "Confirm password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _confirmPasswordObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordObscureText = !_confirmPasswordObscureText;
                            });
                          },
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          confirmPassword = val;
                        });
                      },
                      validator: (value){
                        if(value!=password){
                          return 'please confirm correct password';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var result =
                                      await _auth.registerWithEmailAndPassword(
                                          name,email, password,phoneNo);
                                } on FirebaseAuthException catch (error) {
                                  log(error.code);
                                  switch (error.code) {
                                    case "email-already-in-use":
                                      _showToast(context,
                                          "Email already used. Go to login page.");
                                      break;
                                    case "operation-not-allowed":
                                      _showToast(context,
                                          "Server error, please try again later.");
                                      break;
                                    case "invalid-email":
                                      _showToast(
                                          context, "Email address is invalid.");
                                      break;
                                    case "weak-password":
                                      _showToast(
                                          context, "Enter the strong password");
                                      break;
                                    default:
                                      _showToast(context,
                                          "Login failed. Please try again.");
                                  }
                                }
                              }
                            })),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.togScreen();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
