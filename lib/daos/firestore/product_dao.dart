import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/product.dart';

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

  Future<String> addProduct(String shopId, Product product) async {
    final doc = await _getProductColReference(shopId).add(product);
    return doc.id;
  }

  Future<void> setProduct(String shopId, Product product) async {
    await _getProductReference(shopId, product.productId).set(product);
  }

  Future<void> deleteProduct(String shopId, String productId) async {
    await _getProductReference(shopId, productId).delete();
  }

  Stream<Product> getProductStream(String shopId, String productId) {
    return _getProductReference(shopId, productId)
        .snapshots()
        .map((snap) => snap.data()!);
  }

  Stream<List<Product>> getProductListStream(String shopId) {
    return _getProductColReference(shopId).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }
}
