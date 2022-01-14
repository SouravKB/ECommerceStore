import 'dart:developer';

import 'package:ecommercestore/daos/firestore/shop_dao.dart';
import 'package:ecommercestore/repositories/product_repo.dart';
import 'package:ecommercestore/ui/home/cart_page.dart';
import 'package:ecommercestore/ui/home/category_update.dart';
import 'package:ecommercestore/ui/home/product_input.dart';
import 'package:ecommercestore/ui/home/product_page.dart';
import 'package:ecommercestore/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final categoriesStream =
      ProductRepo.instance.getCategoriesStream(widget.shopId);
  late final isOwnerStream =
      ShopDao.instance.getShopStream(widget.shopId).map((shop) {
    return shop.ownerIds.contains(FirebaseAuth.instance.currentUser!.uid);
  });

  Map<String, int> orderMap = {'price': 0};

  Future<bool> _onBackPressed() async {
    if (orderMap.length > 1) {
      final res = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          log("builder");
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('you want to Discard this order'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  log('cancan');
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: const Text('Discard'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                child: const Text('place the order'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
      log(res.toString());
      return res;
    }
    else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    log((ModalRoute.of(context)?.settings.name.toString() ?? 'null') + 'cat');
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: StreamBuilder<bool>(
          stream: isOwnerStream,
          builder: (context, snap) {
            return Scaffold(
              appBar: MyAppBar(
                title: 'Category',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () { 
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                        return CartPage(orderMap: orderMap, shopId: widget.shopId);
                      }));
                    },
                  )
                ],
              ),
              body: StreamBuilder<List<String>>(
                stream: categoriesStream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
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
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductInput(
                                              shopId: widget.shopId,
                                              category: snapshot.data![index],
                                            )));
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ProductPage(
                                      shopId: widget.shopId,
                                      category: snapshot.data![index],
                                      orderMap: orderMap,
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Card(
                                    margin: const EdgeInsets.fromLTRB(
                                        20, 6.0, 20, 0),
                                    child: ListTile(
                                      leading: const Icon(Icons.shop),
                                      title: Text(snapshot.data![index]),
                                      trailing: (snap.data!)
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
                                              onSelected: (item) =>
                                                  selectedItem(context, item,
                                                      snapshot.data![index]),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    case ConnectionState.none:
                      log(snapshot.error.toString());
                      log(snapshot.data.toString());
                      return const Text('ErrorHappened');
                  }
                },
              ),
              floatingActionButton: (snap.data ?? false)
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductInput(shopId: widget.shopId)));
                      },
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.pinkAccent,
                    )
                  : null,
            );
          }),
    );
  }

  void selectedItem(BuildContext context, Object? item, String category) {
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryUpdate(
                  shopId: widget.shopId,
                  category: category,
                )));
        break;
      case 1:
        ProductRepo.instance.deleteProductsForCategory(widget.shopId, category);
        setState(() {});
        break;
    }
  }
}

/*class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key, required this.shopId}) : super(key: key) {
    categoryList = categoryInstance.getCategoryListStream(shopId);
  }

  final String shopId;
  final categoryInstance = CategoryDao.instance;
  late Stream<List<Category>> categoryList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: categoryList,
        builder: (BuildContext context,AsyncSnapshot<List<Category>> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Visibility(
                  visible: snapshot.hasData,
                  child: Text(
                    snapshot.data.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}*/
