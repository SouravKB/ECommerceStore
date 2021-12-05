// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension ShopCfs on Shop {
  static const docShop = "Shop";
  static const keyShopId = "shopId";
  static const keyOwnerIds = "ownerIds";
  static const keyShopPicUrl = "shopPicUrl";
  static const keyType = "type";
  static const keyEmailIds = "emailIds";
  static const keyPhoneNos = "phoneNos";
  static const keyAddress = "address";
  static const keyOpenTime = "openTime";
  static const keyCloseTime = "closeTime";
  static const keyIsOpen = "isOpen";

  Map<String, Object?> toMap() => {
        keyShopId: shopId,
        keyOwnerIds: ownerIds,
        keyShopPicUrl: shopPicUrl,
        keyType: type,
        keyEmailIds: emailIds,
        keyPhoneNos: phoneNos,
        keyAddress: address,
        keyOpenTime: openTime,
        keyCloseTime: closeTime,
        keyIsOpen: isOpen,
      };

  static Shop fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => Shop(
    shopId: snap.id,
        ownerIds: snap[keyOwnerIds] as List<String>,
        shopPicUrl: snap[keyShopPicUrl] as String,
        type: snap[keyType] as String,
        emailIds: snap[keyEmailIds] as List<String>,
        phoneNos: snap[keyPhoneNos] as List<String>,
        address: snap[keyAddress] as String,
        openTime: snap[keyOpenTime] as int,
        closeTime: snap[keyCloseTime] as int,
        isOpen: snap[keyIsOpen] as bool,
      );
}
