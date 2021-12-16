import 'package:ecommercestore/services/auth.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: MyAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
