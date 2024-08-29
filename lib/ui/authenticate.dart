import 'package:ecommercestore/ui/authentication/login.dart';
import 'package:ecommercestore/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<String?>(context);
    if (userId == null) {
      return const Login();
    } else {
      return const MainPage();
    }
  }
}
