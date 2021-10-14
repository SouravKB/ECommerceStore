import 'package:ecommercestore/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key, required this.title, this.actions, this.leadingAction})
      : super(key: key);

  final String title;
  final List<IconButton>? actions;
  final IconButton? leadingAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingAction,
      title: Text(title, style: titleFont),
      backgroundColor: primaryColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
