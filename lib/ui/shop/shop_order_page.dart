import 'dart:developer';

import 'package:ecommercestore/models/ui/order.dart';
import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/repositories/order_repo.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/ui/order/order_details.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ShopOrderPage extends StatelessWidget {
  ShopOrderPage({Key? key, required this.shopId}) : super(key: key);

  final String shopId;
  late final orderStream = OrderRepo.instance.getOrderListStreamForShop(shopId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Orders Page',
      ),
      body: StreamBuilder<List<Order>>(
          initialData: const [],
          stream: orderStream,
          builder: (context, snapshot) {
            final orders = snapshot.data;
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return OrderDetails(orderId: orders![index].orderId);
                          }));
                        },
                        child: Card(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                  child: Text(
                                    '${orders![index].orderDateTime.day.toString().padLeft(2, '0')}-${orders[index].orderDateTime.month.toString().padLeft(2, '0')}-${orders[index].orderDateTime.year.toString()}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                  child: StreamBuilder<Shop>(
                                      stream: ShopRepo.instance
                                          .getShopStream(shopId),
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.data?.name ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        );
                                      }),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                          'Quantity: ${orders[index].productIdsWithCount.length.toString()}',
                                          style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                        ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Cost: ${orders[index].price}'),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              case ConnectionState.none:
                log(snapshot.error.toString());
                return const Text('ErrorHappened');
            }
          }),
    );
  }
}
