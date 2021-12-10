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
  static const colOpenTime = "openTime";
  static const typeOfOpenTime = "TEXT NOT NULL";
  static const colCloseTime = "closeTime";
  static const typeOfCloseTime = "TEXT NOT NULL";
  static const colIsCurrentlyOpen = "isCurrentlyOpen";
  static const typeOfIsCurrentlyOpen = "INTEGER NOT NULL";

  Map<String, Object?> toMap() => {
        colShopId: shopId,
        colName: name,
        colShopPicUrl: shopPicUrl,
        colType: type,
        colAddress: address,
        colOpenTime: openTime.toIso8601String(),
        colCloseTime: closeTime.toIso8601String(),
        colIsCurrentlyOpen: isCurrentlyOpen ? 1 : 0,
      };

  static Shop fromMap(Map<String, Object?> map) => Shop(
    shopId: map[colShopId] as String,
        name: map[colName] as String,
        shopPicUrl: map[colShopPicUrl] as String?,
        type: map[colType] as String,
        address: map[colAddress] as String,
        openTime: DateTime.parse(map[colOpenTime] as String),
        closeTime: DateTime.parse(map[colCloseTime] as String),
        isCurrentlyOpen: map[colIsCurrentlyOpen] == 1,
      );
}
