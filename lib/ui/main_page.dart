import 'package:ecommercestore/ui/shop_details.dart';
import 'package:ecommercestore/ui/user_profile.dart';
import 'package:ecommercestore/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currentIndex = 0;
  static final screens = [
    ShopPage(),
    UserProfile(),
  ];
  static const items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_box_rounded), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        items: items,
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
      ));
}
