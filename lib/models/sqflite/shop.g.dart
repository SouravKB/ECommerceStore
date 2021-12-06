// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ShopSqfl on Shop {
  static const tableShop = "Shop";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colShopPicUrl = "shopPicUrl";
  static const typeOfShopPicUrl = "TEXT";
  static const colType = "type";
  static const typeOfType = "TEXT NOT NULL";
  static const colAddress = "address";
  static const typeOfAddress = "TEXT NOT NULL";
  static const colOpenTime = "openTime";
  static const typeOfOpenTime = "INTEGER NOT NULL";
  static const colCloseTime = "closeTime";
  static const typeOfCloseTime = "INTEGER NOT NULL";
  static const colIsOpen = "isOpen";
  static const typeOfIsOpen = "INTEGER NOT NULL";

  Map<String, Object?> toMap() => {
        colShopId: shopId,
        colShopPicUrl: shopPicUrl,
        colType: type,
        colAddress: address,
        colOpenTime: openTime,
        colCloseTime: closeTime,
        colIsOpen: isOpen ? 1 : 0,
      };

  static Shop fromMap(Map<String, Object?> map) => Shop(
        shopId: map[colShopId] as String,
        shopPicUrl: map[colShopPicUrl] as String?,
        type: map[colType] as String,
        address: map[colAddress] as String,
        openTime: map[colOpenTime] as int,
        closeTime: map[colCloseTime] as int,
        isOpen: map[colIsOpen] == 1,
      );
}
