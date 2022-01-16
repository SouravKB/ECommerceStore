import 'package:ecommercestore/services/auth_service.dart';
import 'package:ecommercestore/ui/authentication/register.dart';
import 'package:ecommercestore/ui/authentication/reset_password.dart';
import 'package:ecommercestore/ui/main_page.dart';
import 'package:ecommercestore/util/toast.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/login_form_hint_text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  final _emailTextController = TextEditingController();
  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Login',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Icon(
                    Icons.person_outlined,
                    color: Colors.grey,
                    size: 140,
                  ),
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Login to continue",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      return !EmailValidator.validate(email ?? '')
                          ? 'Enter valid email'
                          : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 30,
                      ),
                      labelText: "Password",
                      labelStyle: const LoginFormHintTextStyle(),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() =>
                              _passwordObscureText = !_passwordObscureText);
                        },
                      ),
                    ),
                    obscureText: _passwordObscureText,
                    onChanged: (val) {
                      setState(() => _password = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ResetPassword(),
                          ));
                        },
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await AuthService.instance
                                .loginWithEmailAndPassword(_email, _password);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                          } on FirebaseAuthException catch (error) {
                            _handleLoginError(error.code);
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?  "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const Register(),
                          ));
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

  void _handleLoginError(String errorCode) {
    switch (errorCode) {
      case "wrong-password":
        showToast(context, "Wrong email/password combination.");
        break;
      case "user-not-found":
        showToast(context, "No user found with this email");
        break;
      case "user-disabled":
        showToast(
            context, "This user has been disabled, contact customer service");
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        showToast(context,
            "Too many requests to log into this account, try again after some time");
        break;
      case "operation-not-allowed":
        showToast(context, "Server error, please try again later");
        break;
      case "invalid-email":
        showToast(context, "Entered email is invalid");
        break;
      default:
        showToast(context, "Login failed, please try again later");
    }
  }
}
