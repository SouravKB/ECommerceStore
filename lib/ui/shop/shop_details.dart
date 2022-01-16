import 'dart:developer';

import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/ui/shop/category_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  final shopRepo = ShopRepo.instance;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const MyAppBar(
          title: 'Shop page',
        ),
        body: StreamBuilder<List<Shop>>(
          initialData: const [],
          stream: shopRepo.getShopListStream(),
          builder: (context, snapshot) {
            log(snapshot.data?.toString() ?? 'null+pic');
            if (snapshot.data == null) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          log('shop click');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoryPage(
                                shopId: snapshot.data![index].shopId);
                          }));
                        },
                        child: buildImageInteractionCard(snapshot.data![index])),
                  );
                });
          },
        ),
      );

  Widget buildImageInteractionCard(Shop shop) => Card(
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
                    onTap: () {},
                  ),
                  height: 200,
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
                style: const TextStyle(
                    fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
}
