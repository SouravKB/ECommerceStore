import 'dart:developer';

import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/ui/home/category_update.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool trailing;
  final String shopId;

  const CategoryTile(
      {Key? key,
      required this.category,
      required this.trailing,
      required this.shopId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("category");
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6.0, 20, 0),
        child: ListTile(
          leading: const Icon(Icons.shop),
          title: Text(category),
          trailing: trailing
              ? PopupMenuButton(
                  icon: const Icon(Icons.more),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: const [
                            Icon(Icons.update),
                            Text("Update"),
                          ],
                        )),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          Text("delete"),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (item) => selectedItem(context, item),
                )
              : null,
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryUpdate(shopId: shopId, category: category,)));
        break;
      case 1:
        ProductRepo.instance.deleteProductsForCategory(shopId, category);
        break;
    }
  }
}
