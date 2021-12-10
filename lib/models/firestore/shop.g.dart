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
  static const keyOpenTime = "openTime";
  static const keyCloseTime = "closeTime";
  static const keyIsCurrentlyOpen = "isCurrentlyOpen";

  Map<String, Object?> toMap() => {
        keyShopId: shopId,
        keyOwnerIds: ownerIds,
        keyName: name,
        keyShopPicUrl: shopPicUrl,
        keyType: type,
        keyPhoneNos: phoneNos,
        keyEmailIds: emailIds,
        keyAddress: address,
        keyOpenTime: openTime,
        keyCloseTime: closeTime,
        keyIsCurrentlyOpen: isCurrentlyOpen,
      };

  static Shop fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => Shop(
    shopId: snap.id,
        ownerIds: snap[keyOwnerIds] as List<String>,
        name: snap[keyName] as String,
        shopPicUrl: snap[keyShopPicUrl] as String?,
        type: snap[keyType] as String,
        phoneNos: snap[keyPhoneNos] as List<String>,
        emailIds: snap[keyEmailIds] as List<String>,
        address: snap[keyAddress] as String,
        openTime: snap[keyOpenTime] as DateTime,
        closeTime: snap[keyCloseTime] as DateTime,
        isCurrentlyOpen: snap[keyIsCurrentlyOpen] as bool,
      );
}
