// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_data.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ShopDataSqfl on ShopData {
  static const tableShopData = "ShopData";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colData = "data";
  static const typeOfData = "TEXT NOT NULL";
  static const colType = "type";
  static const typeOfType = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colShopId: shopId,
        colData: data,
        colType: type,
      };

  static ShopData fromMap(Map<String, Object?> map) => ShopData(
        shopId: map[colShopId] as String,
        data: map[colData] as String,
        type: map[colType] as String,
      );
}
