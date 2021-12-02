// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension ShopCfs on Shop {
  static const docShop = "Shop";
  static const keyShopId = "shopId";
  static const keyShopPic = "shopPic";
  static const keyCategory = "category";
  static const keyEmailIds = "emailIds";
  static const keyPhoneNos = "phoneNos";
  static const keyAddress = "address";
  static const keyOpenTime = "openTime";
  static const keyCloseTime = "closeTime";
  static const keyIsOpen = "isOpen";
  static const keyOrderIds = "orderIds";

  Map<String, Object?> toMap() => {
        keyShopId: shopId,
        keyShopPic: shopPic,
        keyCategory: category,
        keyEmailIds: emailIds,
        keyPhoneNos: phoneNos,
        keyAddress: address,
        keyOpenTime: openTime,
        keyCloseTime: closeTime,
        keyIsOpen: isOpen,
        keyOrderIds: orderIds,
      };

  static Shop fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => Shop(
        shopId: snap.id,
        shopPic: snap[keyShopPic] as String,
        category: snap[keyCategory] as String,
        emailIds: snap[keyEmailIds] as List<String>,
        phoneNos: snap[keyPhoneNos] as List<String>,
        address: snap[keyAddress] as String,
        openTime: snap[keyOpenTime] as int,
        closeTime: snap[keyCloseTime] as int,
        isOpen: snap[keyIsOpen] as bool,
        orderIds: snap[keyOrderIds] as List<String>,
      );
}
