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

  Future<void> setProduct(
      String shopId, String categoryId, Product product) async {
    await _getProductReference(shopId, categoryId, product.productId)
        .set(product);
  }

  Future<void> deleteProduct(
      String shopId, String categoryId, String productId) async {
    await _getProductReference(shopId, categoryId, productId).delete();
  }

  Stream<Product> getProductStream(
      String shopId, String categoryId, String productId) {
    return _getProductReference(shopId, categoryId, productId)
        .snapshots()
        .map((snap) => snap.data()!);
  }

  Stream<List<Product>> getProductListStream(String shopId, String categoryId) {
    return _getProductColReference(shopId, categoryId).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }
}
