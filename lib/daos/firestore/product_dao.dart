import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/product.dart';
import 'package:stream_transform/stream_transform.dart';

class ProductDao {
  ProductDao._();

  static final instance = ProductDao._();

  static const _keyShops = 'shops';
  static const _keyProducts = 'products';

  CollectionReference<Product> _getProductColReference(String shopId) {
    return FirebaseFirestore.instance
        .collection(_keyShops)
        .doc(shopId)
        .collection(_keyProducts)
        .withConverter<Product>(
          fromFirestore: (snap, _) => ProductCfs.fromSnapshot(snap),
          toFirestore: (product, _) => product.toMap(),
        );
  }

  DocumentReference<Product> _getProductReference(
      String shopId, String productId) {
    return _getProductColReference(shopId).doc(productId);
  }

  Query<Product> _getCategoryProductReference(String shopId, String category) {
    return FirebaseFirestore.instance
        .collection(_keyShops)
        .doc(shopId)
        .collection(_keyProducts)
        .where('category', isEqualTo: category)
        .withConverter<Product>(
          fromFirestore: (snap, _) => ProductCfs.fromSnapshot(snap),
          toFirestore: (product, _) => product.toMap(),
        );
  }

  Future<String> addProduct(String shopId, Product product) async {
    final doc = await _getProductColReference(shopId).add(product);
    return doc.id;
  }

  Future<void> setProduct(String shopId, Product product) async {
    await _getProductReference(shopId, product.productId).set(product);
  }

  Future<void> setProductCategoryForCategory(
      String shopId, String category, String newCategory) async {
    final queryResult =
        await _getCategoryProductReference(shopId, category).get();
    for (final docRef in queryResult.docs) {
      docRef.reference.update({'category': newCategory});
    }
  }

  Future<void> deleteProduct(String shopId, String productId) async {
    await _getProductReference(shopId, productId).delete();
  }

  Future<void> deleteProductsForCategory(String shopId, String category) async {
    final queryResult =
        await _getCategoryProductReference(shopId, category).get();
    for (final docRef in queryResult.docs) {
      docRef.reference.delete();
    }
  }

  Stream<Product> getProductStream(String shopId, String productId) {
    return _getProductReference(shopId, productId)
        .snapshots()
        .map((snap) => snap.data()!);
  }

  Stream<List<Product>> getProductListStream(
      String shopId, List<String> productIds) {
    final productStreams = <Stream<Product>>[];
    for (final productId in productIds) {
      productStreams.add(_getProductReference(shopId, productId)
          .snapshots()
          .map((snap) => snap.data()!));
    }
    return productStreams[0].combineLatestAll(productStreams.sublist(1));
  }

  Stream<List<Product>> getProductListStreamForShop(String shopId) {
    return _getProductColReference(shopId).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }

  Stream<List<Product>> getProductListStreamForCategory(
      String shopId, String category) {
    return _getCategoryProductReference(shopId, category).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }
}
