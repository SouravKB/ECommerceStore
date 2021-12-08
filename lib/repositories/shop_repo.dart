import 'package:ecommercestore/daos/firestore/shop_dao.dart' as firestore_daos;
import 'package:ecommercestore/daos/sqflite/shop_dao.dart' as sqflite_daos;
import 'package:ecommercestore/daos/sqflite/shop_data_dao.dart' as sqflite_daos;
import 'package:ecommercestore/daos/sqflite/shop_owner_dao.dart'
    as sqflite_daos;
import 'package:ecommercestore/models/firestore/shop.dart' as firestore_models;
import 'package:ecommercestore/models/sqflite/shop.dart' as sqflite_models;
import 'package:ecommercestore/models/sqflite/shop_data.dart' as sqflite_models;
import 'package:ecommercestore/models/sqflite/shop_owner.dart'
    as sqflite_models;
import 'package:ecommercestore/models/ui/shop.dart';

class ShopRepo {
  ShopRepo._();

  static final instance = ShopRepo._();

  final _firestoreShopDao = firestore_daos.ShopDao.instance;
  final _sqfliteShopDao = sqflite_daos.ShopDao.instance;
  final _sqfliteShopDataDao = sqflite_daos.ShopDataDao.instance;
  final _sqfliteShopOwnerDao = sqflite_daos.ShopOwnerDao.instance;

  Stream<Shop> getShopStream(String shopId) async* {
    await for (final cfsShop in _firestoreShopDao.getShopStream(shopId)) {
      final sqflShop = sqflite_models.Shop(
          shopId: cfsShop.shopId,
          shopPicUrl: cfsShop.shopPicUrl,
          type: cfsShop.type,
          address: cfsShop.address,
          openTime: cfsShop.openTime,
          closeTime: cfsShop.closeTime,
          isOpen: cfsShop.isOpen);
      _sqfliteShopDao.insertShop(sqflShop);

      for (final data in cfsShop.emailIds) {
        final shopData = sqflite_models.ShopData(
            shopId: cfsShop.shopId, data: data, type: 'emailId');
        _sqfliteShopDataDao.insertShopData(shopData);
      }

      for (final data in cfsShop.phoneNos) {
        final shopData = sqflite_models.ShopData(
            shopId: cfsShop.shopId, data: data, type: 'phoneNo');
        _sqfliteShopDataDao.insertShopData(shopData);
      }

      for (final owner in cfsShop.ownerIds) {
        final shopOwner =
            sqflite_models.ShopOwner(ownerId: owner, shopId: shopId);
        _sqfliteShopOwnerDao.insertShopOwner(shopOwner);
      }

      yield Shop(
          shopId: cfsShop.shopId,
          shopPicUrl: cfsShop.shopPicUrl,
          type: cfsShop.type,
          emailIds: cfsShop.emailIds,
          phoneNos: cfsShop.phoneNos,
          address: cfsShop.address,
          openTime: cfsShop.openTime,
          closeTime: cfsShop.closeTime,
          isOpen: cfsShop.isOpen);
    }
  }

  Future<void> addShop(Shop shop) async {
    await updateShop(shop);
  }

  Future<void> updateShop(Shop shop) async {
    final shopOwners = await _sqfliteShopOwnerDao.getShopOwnerList(shop.shopId);
    final ownerIds =
        shopOwners.map((owner) => owner.ownerId).toList(growable: false);
    final cfsShop = firestore_models.Shop(
      shopId: shop.shopId,
      ownerIds: ownerIds,
      shopPicUrl: shop.shopPicUrl,
      type: shop.type,
      emailIds: shop.emailIds,
      phoneNos: shop.phoneNos,
      address: shop.address,
      openTime: shop.openTime,
      closeTime: shop.closeTime,
      isOpen: shop.isOpen,
    );
    await _firestoreShopDao.setShop(cfsShop);
  }
}
