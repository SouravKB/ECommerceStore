import 'dart:developer';

import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/ui/authentication/authenticate.dart';
import 'package:ecommercestore/ui/home/home.dart';
import 'package:ecommercestore/ui/home/shop_register.dart';
import 'package:ecommercestore/ui/home/user_edit.dart';
import 'package:ecommercestore/ui/main_page.dart';
import 'package:ecommercestore/ui/profile_menu.dart';
import 'package:ecommercestore/ui/shop_details.dart';
import 'package:ecommercestore/ui/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
      return const MainPage();/*StreamBuilder<User>(
        stream: UserRepo.instance.getUserStream(auth.FirebaseAuth.instance.currentUser!.uid),
        builder: (context,snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              case ConnectionState.active:
              case ConnectionState.done:
                log(snapshot.data == null ? 'null' : 'notn');
                log(snapshot.error.toString());
                return UserEdit(user :snapshot.data!);
                return UserEdit(user :snapshot.data!);
              case ConnectionState.none:
                log(snapshot.error.toString());
                return const Text('ErrorHappened');
            }
        },
      );*/
    }
  }
}
