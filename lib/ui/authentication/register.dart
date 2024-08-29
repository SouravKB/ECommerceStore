import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/services/auth_service.dart';
import 'package:ecommercestore/ui/authentication/login.dart';
import 'package:ecommercestore/util/toast.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/login_form_hint_text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNo = '';
  String _password = '';
  String _confirmPassword = '';

  final _emailTextController = TextEditingController();
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
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Icon(
                      Icons.person_outlined,
                      color: Colors.grey,
                      size: 140,
                    ),
                    const Text(
                      "Create account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Create account to continue",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autofillHints: const [AutofillHints.name],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        labelText: "Name",
                        labelStyle: LoginFormHintTextStyle(),
                      ),
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
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
                      autofillHints: const [AutofillHints.telephoneNumber],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 30,
                        ),
                        labelText: "Phone Number",
                        labelStyle: LoginFormHintTextStyle(),
                      ),
                      onChanged: (val) {
                        setState(() => _phoneNo = val);
                      },
                      validator: (value) {
                        const pattern = r'^(?:\+91)?[0-9]{10}$';
                        return !RegExp(pattern).hasMatch(value ?? '')
                            ? 'Enter valid phone number'
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
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 30,
                        ),
                        labelText: "Confirm password",
                        labelStyle: const LoginFormHintTextStyle(),
                        suffixIcon: IconButton(
                          icon: Icon(_confirmPasswordObscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _confirmPasswordObscureText =
                                !_confirmPasswordObscureText);
                          },
                        ),
                      ),
                      obscureText: _confirmPasswordObscureText,
                      onChanged: (val) {
                        setState(() => _confirmPassword = val);
                      },
                      validator: (value) {
                        if (value != _password) {
                          return 'Password mismatch';
                        } else {
                          return null;
                        }
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
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              var uid = await AuthService.instance
                                  .registerWithEmailAndPassword(
                                      _email, _password);
                              final user =
                                  _newUser(uid!, _name, _email, _phoneNo);
                              UserRepo.instance.addUser(user);
                            } on auth.FirebaseAuthException catch (error) {
                              _handleRegisterError(error.code);
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?  "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
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

  void _handleRegisterError(String errorCode) {
    switch (errorCode) {
      case "email-already-in-use":
        showToast(context, "Entered email is already in use");
        break;
      case "operation-not-allowed":
        showToast(context, "Server error, please try again later");
        break;
      case "invalid-email":
        showToast(context, "Entered email is invalid");
        break;
      case "weak-password":
        showToast(context, "Entered password is too weak");
        break;
      default:
        showToast(context, "Register failed, please try again later");
    }
  }

  User _newUser(String uid, String name, String email, String phoneNo) {
    return User(
      userId: uid,
      name: name,
      profilePicUrl: null,
      emailIds: [email],
      phoneNos: [phoneNo],
      addresses: [],
    );
  }
}
