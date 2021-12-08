import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/shop.dart';

class ShopDao {
  ShopDao._();

  static final instance = ShopDao._();

  static const _keyShops = 'shops';

  CollectionReference<Shop> _getShopColReference() {
    return FirebaseFirestore.instance.collection(_keyShops).withConverter<Shop>(
          fromFirestore: (snap, _) => ShopCfs.fromSnapshot(snap),
          toFirestore: (shop, _) => shop.toMap(),
        );
  }

  DocumentReference<Shop> _getShopReference(String shopId) {
    return _getShopColReference().doc(shopId);
  }

  Future<void> setShop(Shop shop) async {
    await _getShopReference(shop.shopId).set(shop);
  }

  Future<void> deleteShop(String shopId) async {
    await _getShopReference(shopId).delete();
  }

  Stream<Shop> getShopStream(String shopId) {
    return _getShopReference(shopId).snapshots().map((snap) => snap.data()!);
  }
}
