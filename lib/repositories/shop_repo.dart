import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:ecommercestore/util/locationdata_extensions.dart';
import 'package:ecommercestore/util/timeofday_extensions.dart';
import 'package:location/location.dart';

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
          name: cfsShop.name,
          shopPicUrl: cfsShop.shopPicUrl,
          type: cfsShop.type,
          address: cfsShop.address,
          location:
              '${cfsShop.location.latitude} ${cfsShop.location.longitude}',
          openTime: cfsShop.openTime,
          closeTime: cfsShop.closeTime,
          isOpenNow: cfsShop.isOpenNow);
      _sqfliteShopDao.insertShop(sqflShop);

      for (final data in cfsShop.phoneNos) {
        final shopData = sqflite_models.ShopData(
            shopId: cfsShop.shopId, data: data, type: 'phoneNo');
        _sqfliteShopDataDao.insertShopData(shopData);
      }

      for (final data in cfsShop.emailIds) {
        final shopData = sqflite_models.ShopData(
            shopId: cfsShop.shopId, data: data, type: 'emailId');
        _sqfliteShopDataDao.insertShopData(shopData);
      }

      for (final owner in cfsShop.ownerIds) {
        final shopOwner =
        sqflite_models.ShopOwner(ownerId: owner, shopId: shopId);
        _sqfliteShopOwnerDao.insertShopOwner(shopOwner);
      }

      yield Shop(
          shopId: cfsShop.shopId,
          ownerIds: cfsShop.ownerIds,
          name: cfsShop.name,
          shopPicUrl: cfsShop.shopPicUrl,
          type: cfsShop.type,
          emailIds: cfsShop.emailIds,
          phoneNos: cfsShop.phoneNos,
          address: cfsShop.address,
          location: LocationData.fromMap({
            'latitude': cfsShop.location.latitude,
            'longitude': cfsShop.location.longitude,
          }),
          openTime: TimeInMinutes.toTimeOfDay(cfsShop.openTime),
          closeTime: TimeInMinutes.toTimeOfDay(cfsShop.closeTime),
          isOpenNow: cfsShop.isOpenNow);
    }
  }

  Stream<List<Shop>> getShopListStream() async* {
    await for (final shops in _firestoreShopDao.getShopListStream()) {
      for (final cfsShop in shops) {
        final sqflShop = sqflite_models.Shop(
            shopId: cfsShop.shopId,
            name: cfsShop.name,
            shopPicUrl: cfsShop.shopPicUrl,
            type: cfsShop.type,
            address: cfsShop.address,
            location:
                '${cfsShop.location.latitude} ${cfsShop.location.longitude}',
            openTime: cfsShop.openTime,
            closeTime: cfsShop.closeTime,
            isOpenNow: cfsShop.isOpenNow);
        _sqfliteShopDao.insertShop(sqflShop);

        for (final data in cfsShop.phoneNos) {
          final shopData = sqflite_models.ShopData(
              shopId: cfsShop.shopId, data: data, type: 'phoneNo');
          _sqfliteShopDataDao.insertShopData(shopData);
        }

        for (final data in cfsShop.emailIds) {
          final shopData = sqflite_models.ShopData(
              shopId: cfsShop.shopId, data: data, type: 'emailId');
          _sqfliteShopDataDao.insertShopData(shopData);
        }

        for (final owner in cfsShop.ownerIds) {
          final shopOwner =
          sqflite_models.ShopOwner(ownerId: owner, shopId: cfsShop.shopId);
          _sqfliteShopOwnerDao.insertShopOwner(shopOwner);
        }
      }

      yield shops
          .map((shop) => Shop(
          shopId: shop.shopId,
              ownerIds: shop.ownerIds,
              name: shop.name,
              shopPicUrl: shop.shopPicUrl,
              type: shop.type,
              emailIds: shop.emailIds,
              phoneNos: shop.phoneNos,
              address: shop.address,
              location: LocationData.fromMap({
                'latitude': shop.location.latitude,
                'longitude': shop.location.longitude,
              }),
              openTime: TimeInMinutes.toTimeOfDay(shop.openTime),
              closeTime: TimeInMinutes.toTimeOfDay(shop.closeTime),
              isOpenNow: shop.isOpenNow))
          .toList(growable: false);
    }
  }

  Stream<List<Shop>> getShopListStreamSortedDistance(LocationData userLoc) {
    return getShopListStream().map((shops) {
      shops.sort((s1, s2) => userLoc.distanceFrom(s1.location).compareTo(
            userLoc.distanceFrom(s2.location),
          ));
      return shops;
    });
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
      name: shop.name,
      shopPicUrl: shop.shopPicUrl,
      type: shop.type,
      emailIds: shop.emailIds,
      phoneNos: shop.phoneNos,
      address: shop.address,
      location: GeoPoint(shop.location.latitude!, shop.location.longitude!),
      openTime: shop.openTime.inMinutes,
      closeTime: shop.closeTime.inMinutes,
      isOpenNow: shop.isOpenNow,
    );
    await _firestoreShopDao.setShop(cfsShop);
  }

  Future<void> deleteShop(String shopId) async {
    await _firestoreShopDao.deleteShop(shopId);
  }
}
