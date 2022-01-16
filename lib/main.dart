import 'package:ecommercestore/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/authenticate.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<String?>.value(
      value: AuthService.instance.userId,
      initialData: null,
      child: MaterialApp(
        title: 'Shopstack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Authenticate(),
      ),
    );
  }
}
