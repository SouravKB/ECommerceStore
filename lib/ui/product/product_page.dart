import 'dart:developer';

import 'package:ecommercestore/daos/firestore/shop_dao.dart';
import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/ui/order/cart_page.dart';
import 'package:ecommercestore/ui/product/product_input.dart';
import 'package:ecommercestore/util/map_extensions.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage(
      {Key? key, required this.shopId, this.category, required this.orderMap})
      : super(key: key);

  final String shopId;
  final String? category;
  final Map<String, int> orderMap;
  late final productList = ProductRepo.instance.getProductListStreamForShop(shopId);
  late final isOwner = ShopDao.instance.getShopStream(shopId).map(
      (shop) => shop.ownerIds.contains(FirebaseAuth.instance.currentUser!.uid));

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.isOwner,
        builder: (context, snap) {
          return Scaffold(
            appBar: MyAppBar(
              title: 'Products',
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                      return CartPage(orderMap: widget.orderMap, shopId: widget.shopId);
                    }));
                  },
                )
              ],
            ),
            body: StreamBuilder<List<Product>>(
                stream: widget.productList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 24),
                            ),
                          ),
                        ],
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            product: snapshot.data![index],
                            increment: (product) {
                              setState(() {
                                widget.orderMap
                                    .putIfAbsent(product.productId, () => 0);
                                widget.orderMap[product.productId] =
                                    widget.orderMap[product.productId]! + 1;
                                widget.orderMap['price']=widget.orderMap['price']!+product.price;
                              });
                            },
                            decrement: (product) {
                              setState(() {
                                widget.orderMap[product.productId] =
                                    widget.orderMap[product.productId]! - 1;
                                widget.orderMap.removeIf(
                                    product.productId, (value) => value! == 0);
                                widget.orderMap['price']=widget.orderMap['price']!-product.price;
                              });
                            },
                            isOrdered: false,
                            counter: widget.orderMap[snapshot.data![index].productId] ?? 0,
                            isOwner: snap.data ?? false,
                            shopId: widget.shopId,
                          );
                        },
                      );
                    case ConnectionState.none:
                      log(snapshot.error.toString());
                      return const Text('ErrorHappened');
                  }
                }),
            floatingActionButton: (snap.data ?? false)
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProductInput(
                                    shopId: widget.shopId,
                                    category: widget.category,
                                  )));
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.pinkAccent,
                  )
                : null,
          );
        });
  }
}
