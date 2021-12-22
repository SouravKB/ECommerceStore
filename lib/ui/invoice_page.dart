import 'package:ecommercestore/models/ui/order.dart';
import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/models/ui/shop.dart';
import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/order_repo.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:ecommercestore/widgets/print_text_style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key, required this.orderId}) : super(key: key);

  final String orderId;

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Invoice',
      ),
      body: FutureBuilder<Order>(
        future: OrderRepo.instance.getOrder(widget.orderId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final order = snapshot.data!;
          return StreamBuilder<User>(
            stream: UserRepo.instance.getUserStream(order.userId),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SizedBox.shrink();
              }
              final user = snapshot.data!;
              return StreamBuilder<Shop>(
                stream: ShopRepo.instance.getShopStream(order.shopId),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  final shop = snapshot.data!;
                  return StreamBuilder<List<Product>>(
                    stream: ProductRepo.instance
                        .getProductListStreamForOrderedProducts(
                            order.shopId,
                            order.productIdsWithCount.keys
                                .toList(growable: false)),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const SizedBox.shrink();
                      }
                      final products = snapshot.data!;
                      return RepaintBoundary(
                        key: _printKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox.expand(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  _orderDetails(order, user, shop, products),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.print),
        onPressed: _printScreen,
      ),
    );
  }

  List<Widget> _orderDetails(
          Order order, User user, Shop shop, List<Product> products) =>
      [
        Text(
          shop.name,
          style:
              const PrintTextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          shop.address,
          style: const PrintTextStyle(),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          user.name,
          style:
              const PrintTextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          order.phoneNo,
          style: const PrintTextStyle(),
        ),
        Text(
          order.address,
          style: const PrintTextStyle(),
        ),
        const SizedBox(
          height: 50,
        ),
        ...products.map((product) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const PrintTextStyle(),
                ),
                Text(
                  order.productIdsWithCount[product.productId]!.toString(),
                  style: const PrintTextStyle(),
                ),
                Text(
                  product.price.toString(),
                  style: const PrintTextStyle(),
                ),
              ],
            )),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: PrintTextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              order.price.toString(),
              style: const PrintTextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ];

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          },
        ),
      );

      return doc.save();
    });
  }
}
