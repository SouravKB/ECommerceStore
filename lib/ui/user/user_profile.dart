import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/services/auth_service.dart';
import 'package:ecommercestore/ui/user/user_edit.dart';
import 'package:ecommercestore/ui/user/user_order_page.dart';
import 'package:ecommercestore/ui/user/user_shops_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  File? image;
  String? imageUrl;
  final AuthService _auth = AuthService.instance;
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(Icons.update),
                      Text("Edit profile"),
                    ],
                  )),
            ],
            onSelected: (item) => selectedItem(context, item),
          ),
        ],
      ),
      body: StreamBuilder<User>(
        stream: UserRepo.instance
            .getUserStream(auth.FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
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
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                ],
              );
            case ConnectionState.active:
            case ConnectionState.done:
              log(snapshot.data == null ? 'null' : 'notn');
              log(snapshot.error.toString());
              user = snapshot.data!;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 70,
                                child: ClipOval(
                                  child: snapshot.data!.profilePicUrl == null
                                      ? Image.asset(
                                          "assets/images/profile_pic.jpg",
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          snapshot.data!.profilePicUrl!,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UserOrderPage(userId: snapshot.data!.userId);
                      }));
                    },
                    child: const ListTile(
                      title: Text('My Orders'),
                      leading: Icon(Icons.add_shopping_cart_sharp),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UserShopsPage();
                      }));
                    },
                    child: const ListTile(
                      title: Text('Shops'),
                      leading: Icon(Icons.shop),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _auth.logout();
                    },
                    child: const ListTile(
                      title: Text('log out'),
                      leading: Icon(Icons.logout),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                      title: Text('Settings'),
                      leading: Icon(Icons.settings),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                      title: Text('Support'),
                      leading: Icon(Icons.support),
                    ),
                  ),
                ],
              );
            case ConnectionState.none:
              log(snapshot.error.toString());
              return const Text('ErrorHappened');
          }
        },
      ),
      /*ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              const ProfilePic(),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {

                },
                child: const ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.add_shopping_cart_sharp),
                ),
              ),
              InkWell(
                onTap: () {

                },
                child: const ListTile(
                  title: Text('log out'),
                  leading: Icon(Icons.logout),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Support'),
                  leading: Icon(Icons.support),
                ),
              ),
            ],
          );*/
    );
  }

  void selectedItem(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserEdit(user: user)));
        break;
    }
  }
}
