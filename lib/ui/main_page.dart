import 'package:ecommercestore/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currentIndex = 0;
  static const screens = [
    Center(child: Text('Home', style: TextStyle(fontSize: 24))),
    Center(child: Text('Cart', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];
  static const items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
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
