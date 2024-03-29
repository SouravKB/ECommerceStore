// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ShopSqfl on Shop {
  static const tableShop = "Shop";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colName = "name";
  static const typeOfName = "TEXT NOT NULL";
  static const colShopPicUrl = "shopPicUrl";
  static const typeOfShopPicUrl = "TEXT";
  static const colType = "type";
  static const typeOfType = "TEXT NOT NULL";
  static const colAddress = "address";
  static const typeOfAddress = "TEXT NOT NULL";
  static const colLocation = "location";
  static const typeOfLocation = "TEXT NOT NULL";
  static const colOpenTime = "openTime";
  static const typeOfOpenTime = "INTEGER NOT NULL";
  static const colCloseTime = "closeTime";
  static const typeOfCloseTime = "INTEGER NOT NULL";
  static const colIsOpenNow = "isOpenNow";
  static const typeOfIsOpenNow = "INTEGER NOT NULL";

  Map<String, Object?> toMap() => {
        colShopId: shopId,
        colName: name,
        colShopPicUrl: shopPicUrl,
        colType: type,
        colAddress: address,
        colLocation: location,
        colOpenTime: openTime,
        colCloseTime: closeTime,
        colIsOpenNow: isOpenNow ? 1 : 0,
      };

  static Shop fromMap(Map<String, Object?> map) => Shop(
    shopId: map[colShopId] as String,
        name: map[colName] as String,
        shopPicUrl: map[colShopPicUrl] as String?,
        type: map[colType] as String,
        address: map[colAddress] as String,
        location: map[colLocation] as String,
        openTime: map[colOpenTime] as int,
        closeTime: map[colCloseTime] as int,
        isOpenNow: map[colIsOpenNow] == 1,
      );
}
