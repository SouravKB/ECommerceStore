import 'dart:developer';

import 'package:ecommercestore/ui/authentication/register.dart';
import 'package:ecommercestore/ui/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool switchScreen=true;
  void togScreen() {
    setState(() {
      switchScreen=!switchScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("auth");
    if(switchScreen){
      return SignIn(togScreen:togScreen);
    }
    else{
      return Register(togScreen:togScreen);
    }
  }
}
