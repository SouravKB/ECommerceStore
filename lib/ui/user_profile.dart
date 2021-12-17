import 'package:ecommercestore/ui/profile_pic.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Home page'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.add_shopping_cart_sharp),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: ListTile(
              title: Text('log out'),
              leading: Icon(Icons.logout),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Support'),
              leading: Icon(Icons.support),
            ),
          ),
        ],
      ),
    );
  }
}
