import 'dart:developer';

import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/ui/shop/shop_profile.dart';
import 'package:ecommercestore/ui/shop/shop_register.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserShopsPage extends StatelessWidget {
  final shopRepo = ShopRepo.instance;

  UserShopsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const MyAppBar(
          title: 'User shops',
        ),
        body: StreamBuilder<List<Shop>>(
          initialData: const [],
          stream: shopRepo
              .getShopListStreamForUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            log(snapshot.data?.toString() ?? 'null');
            if (snapshot.data == null) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildImageInteractionCard(
                        context, snapshot.data![index]),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ShopRegister();
            }));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
        ),
      );

  Widget buildImageInteractionCard(BuildContext context, Shop shop) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(
                    shop.shopPicUrl ??
                        'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShopProfile(shopId: shop.shopId);
                      }));
                    },
                  ),
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    shop.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                shop.address,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
}
