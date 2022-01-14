import 'dart:developer';

import 'package:ecommercestore/models/ui/product.dart';
import 'package:ecommercestore/ui/home/product_input.dart';
import 'package:flutter/material.dart';

/*class ProductCard extends StatefulWidget {
  ProductCard({Key? key, required this.product, this.increment, this.decrement,this.counter}) : super(key: key);

  final Product product;
  final Function()? increment;
  final Function()? decrement;
  int? counter;

  @override
  _ProductCardState createState() => _ProductCardState();
}*/

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.product,
    this.increment,
    this.decrement,
    required this.counter,
    required this.isOrdered,
    required this.isOwner,
    required this.shopId,
  }) : super(key: key);

  final Product product;
  final Function(Product product)? increment;
  final Function(Product product)? decrement;
  int counter;
  bool isOrdered;
  bool isOwner;
  final String shopId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 270,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (product.imageUrl != null)
                            ? NetworkImage(product.imageUrl!)
                            : const AssetImage('assets/images/flower.webp')
                                as ImageProvider<Object>,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isOrdered)
                            Text(
                              counter.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.pinkAccent),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        decrement!(product);
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 25,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: Text(
                                      counter.toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        increment!(product);
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 25,
                                      )),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.shortDesc,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Text(
                            product.price.toString(),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              if (isOwner)
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductInput(shopId: shopId,product: product,);
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class _ProductCardState extends State<ProductCard> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 250,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (widget.product.imageUrl != null)
                            ? NetworkImage(widget.product.imageUrl!)
                            : const AssetImage('assets/images/flower.webp')
                                as ImageProvider<Object>,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.pinkAccent),
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: i,
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.white),
                                  child: Text(
                                    _itemCount.toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _itemCount++;
                                        log(_itemCount.toString());
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.shortDesc,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Text(
                            widget.product.price.toString(),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
