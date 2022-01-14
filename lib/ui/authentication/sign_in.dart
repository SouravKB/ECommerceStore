import 'package:ecommercestore/services/auth.dart';
import 'package:ecommercestore/ui/authentication/forgot_password.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/input_decoration.dart';
import 'package:ecommercestore/widgets/text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function togScreen;

  const SignIn({Key? key, required this.togScreen}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = "";
  bool _passwordObscureText = true;

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
                  Icon(
                    Icons.person_outlined,
                    color: Colors.grey[300],
                    size: 140,
                  ),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "sign in continue",
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                        },
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                            "login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                var result =await _auth.signInWithEmailAndPassword(
                                    email, password);
                              } on FirebaseAuthException catch (error) {
                                switch (error.code) {
                                  case "wrong-password":
                                    _showToast(context,
                                        "Wrong email/password combination.");
                                    break;
                                  case "user-not-found":
                                    _showToast(context,
                                        "No user found with this email.");
                                    break;
                                  case "user-disabled":
                                    _showToast(context, "User disabled.");
                                    break;
                                  case "ERROR_TOO_MANY_REQUESTS":
                                    _showToast(context,
                                        "Too many requests to log into this account.");
                                    break;
                                  case "operation-not-allowed":
                                    _showToast(context,
                                        "Server error, please try again later.");
                                    break;
                                  case "invalid-email":
                                    _showToast(
                                        context, "Email address is invalid.");
                                    break;
                                  default:
                                    _showToast(context,
                                        "Login failed.");
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
                        "Don't have an account",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.togScreen();
                        },
                        child: Text(
                          "Register",
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
