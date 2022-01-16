import 'dart:developer';
import 'dart:io';

import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/ui/shop/category_page.dart';
import 'package:ecommercestore/ui/shop/shop_edit.dart';
import 'package:ecommercestore/ui/shop/shop_order_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ShopProfile extends StatelessWidget {
  ShopProfile({Key? key, required this.shopId}) : super(key: key);

  File? image;
  String? imageUrl;
  String shopId;
  late Shop shop;

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
      body: StreamBuilder<Shop>(
        stream: ShopRepo.instance.getShopStream(shopId),
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
              shop = snapshot.data!;
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
                                  child: snapshot.data!.shopPicUrl == null
                                      ? Image.asset(
                                    "assets/images/profile_pic.jpg",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.network(
                                    snapshot.data!.shopPicUrl!,
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
                            return ShopOrderPage(shopId: shopId,);
                          }));
                    },
                    child: const ListTile(
                      title: Text('Shop Orders'),
                      leading: Icon(Icons.add_shopping_cart_sharp),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return CategoryPage(shopId: shopId);
                          }));
                    },
                    child: const ListTile(
                      title: Text('products'),
                      leading: Icon(Icons.category),
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
    );
  }

  void selectedItem(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ShopEdit(shop: shop)));
        break;
    }
  }
}
