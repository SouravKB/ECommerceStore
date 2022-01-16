import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/ui/order/place_order_page.dart';
import 'package:ecommercestore/util/map_extensions.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key, required this.orderMap, required this.shopId})
      : super(key: key);

  Map<String, int> orderMap;
  String shopId;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Cart',
      ),
      body: SizedBox(
        height: 800,
        child: Column(
          children: [
            Text(
              'your total price ${widget.orderMap['price']}',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.orderMap.length,
                itemBuilder: (context, index) {
                  String key = widget.orderMap.keys.elementAt(index);
                  return StreamBuilder<Product>(
                      stream: ProductRepo.instance
                          .getProductStream(widget.shopId, key),
                      builder: (context, snapshot) {
                        return (snapshot.data != null)
                            ? ProductCard(
                                product: snapshot.data!,
                                increment: (product) {
                                  setState(() {
                                    widget.orderMap.putIfAbsent(
                                        product.productId, () => 0);
                                    widget.orderMap[product.productId] =
                                        widget.orderMap[product.productId]! + 1;
                                    widget.orderMap['price'] =
                                        widget.orderMap['price']! +
                                            product.price;
                                  });
                                },
                                decrement: (product) {
                                  setState(() {
                                    widget.orderMap[product.productId] =
                                        widget.orderMap[product.productId]! - 1;
                                    widget.orderMap.removeIf(product.productId,
                                        (value) => value! == 0);
                                    widget.orderMap['price'] =
                                        widget.orderMap['price']! -
                                            product.price;
                                  });
                                },
                                isOrdered: false,
                                isOwner: false,
                                shopId: '',
                                counter: widget.orderMap[key]!,
                              )
                            : const SizedBox.shrink();
                      });
                }),
            SizedBox(
                height: 55,
                width: double.infinity,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: const Text(
                      "Buy items",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PlaceOrderPage(
                            shopId: widget.shopId, orderMap: widget.orderMap);
                      }));
                    })),
          ],
        ),
      ),
    );
  }
}
