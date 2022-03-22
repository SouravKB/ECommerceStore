import 'dart:developer';

import 'package:ecommercestore/models/ui/order.dart';
import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/order_repo.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/ui/invoice/invoice_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/product_card.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final String orderId;
  late final order = OrderRepo.instance.getOrder(orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Order Details',
      ),
      body: FutureBuilder<Order>(
          initialData: null,
          future: order,
          builder: (context, snap) {
            if(snap.data == null) {
              return const SizedBox.shrink();
            }
            return StreamBuilder<Shop>(
                stream: ShopRepo.instance.getShopStream(snap.data!.shopId),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snap.data!.orderDateTime.day.toString().padLeft(2, '0')}-${snap.data!.orderDateTime.month.toString().padLeft(2, '0')}-${snap.data!.orderDateTime.year.toString()}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Quantity: ${snap.data!.productIdsWithCount.length.toString()}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snap.data!.productIdsWithCount.length,
                                itemBuilder: (context, index) {
                                  String productId = snap.data!.productIdsWithCount.keys
                                      .elementAt(index);
                                  log(productId);
                                  final productStream = ProductRepo.instance
                                      .getProductStream(snap.data!.shopId, productId);
                                  return StreamBuilder<Product>(
                                      stream: productStream,
                                      builder: (context, snapshot) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: snapshot.data != null
                                              ? ProductCard(
                                                  counter: snap.data!
                                                      .productIdsWithCount[productId]!,
                                                  product: snapshot.data!,
                                                  isOrdered: true,
                                                  isOwner: false,
                                                  shopId: '',
                                                )
                                              : const SizedBox.shrink(),
                                        );
                                      });
                                }),
                          ),
                          const Text(
                            'Order Information',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'User Mob no :${snap.data!.phoneNo}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'User address :${snap.data!.address}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Shop name :${snapshot.data!.name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Shop address :${snapshot.data!.address}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.phoneNos.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  'Shop Mobile no ${index + 1} :${snapshot.data!.phoneNos[index]}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'payment methode :${snap.data!.payMethod}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InvoicePage(orderId: orderId);
          }));
        },
        label: const Text('Generate invoice'),
      ),
    );
  }
}
