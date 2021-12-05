import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/product.dart';

class ProductDao {
  ProductDao._();

  static final instance = ProductDao._();

  static const _keyShops = 'shops';
  static const _keyCategories = 'categories';
  static const _keyProducts = 'products';

  CollectionReference<Product> _getProductColReference(
      String shopId, String categoryId) {
    return FirebaseFirestore.instance
        .collection(_keyShops)
        .doc(shopId)
        .collection(_keyCategories)
        .doc(categoryId)
        .collection(_keyProducts)
        .withConverter<Product>(
          fromFirestore: (snap, _) => ProductCfs.fromSnapshot(snap),
          toFirestore: (product, _) => product.toMap(),
        );
  }

  DocumentReference<Product> _getProductReference(
      String shopId, String categoryId, String productId) {
    return _getProductColReference(shopId, categoryId).doc(productId);
  }

  Future<String> addProduct(
      String shopId, String categoryId, Product product) async {
    final doc = await _getProductColReference(shopId, categoryId).add(product);
    return doc.id;
  }

  void setProduct(String shopId, String categoryId, Product product) async {
    await _getProductReference(shopId, categoryId, product.productId)
        .set(product);
  }

  void deleteProduct(String shopId, String categoryId, String productId) async {
    await _getProductReference(shopId, categoryId, productId).delete();
  }

  Future<Product> getProduct(
      String shopId, String categoryId, String productId) async {
    final doc = await _getProductReference(shopId, categoryId, productId).get();
    return doc.data()!;
  }

  Future<List<Product>> getProductList(String shopId, String categoryId) async {
    final querySnap = await _getProductColReference(shopId, categoryId).get();
    final productList = <Product>[];
    for (final doc in querySnap.docs) {
      productList.add(doc.data());
    }
    return productList;
  }
}
