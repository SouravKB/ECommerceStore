// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension ShopCfs on Shop {
  static const docShop = "Shop";
  static const keyShopId = "shopId";
  static const keyOwnerIds = "ownerIds";
  static const keyName = "name";
  static const keyShopPicUrl = "shopPicUrl";
  static const keyType = "type";
  static const keyPhoneNos = "phoneNos";
  static const keyEmailIds = "emailIds";
  static const keyAddress = "address";
  static const keyLocation = "location";
  static const keyOpenTime = "openTime";
  static const keyCloseTime = "closeTime";
  static const keyIsOpenNow = "isOpenNow";

  Map<String, Object?> toMap() => {
        keyShopId: shopId,
        keyOwnerIds: ownerIds,
        keyName: name,
        keyShopPicUrl: shopPicUrl,
        keyType: type,
        keyPhoneNos: phoneNos,
        keyEmailIds: emailIds,
        keyAddress: address,
        keyLocation: location,
        keyOpenTime: openTime,
        keyCloseTime: closeTime,
        keyIsOpenNow: isOpenNow,
      };

  static Shop fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => Shop(
        shopId: snap.id,
        ownerIds: (snap[keyOwnerIds] as List)
            .map((item) => item as String)
            .toList(growable: false),
        name: snap[keyName] as String,
        shopPicUrl: snap[keyShopPicUrl] as String?,
        type: snap[keyType] as String,
        phoneNos: (snap[keyPhoneNos] as List)
            .map((item) => item as String)
            .toList(growable: false),
        emailIds: (snap[keyEmailIds] as List)
            .map((item) => item as String)
            .toList(growable: false),
        address: snap[keyAddress] as String,
        location: snap[keyLocation] as GeoPoint,
        openTime: (snap[keyOpenTime] as num).toInt(),
        closeTime: (snap[keyCloseTime] as num).toInt(),
        isOpenNow: snap[keyIsOpenNow] as bool,
      );
}
