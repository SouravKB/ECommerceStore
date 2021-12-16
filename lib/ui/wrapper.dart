import 'dart:developer';

import 'package:ecommercestore/ui/authentication/authenticate.dart';
import 'package:ecommercestore/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log((ModalRoute.of(context)?.settings.name.toString() ?? 'null') + 'warp');
    final userId = Provider.of<String?>(context);
    if (userId == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
