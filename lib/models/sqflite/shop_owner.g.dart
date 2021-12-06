// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_owner.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ShopOwnerSqfl on ShopOwner {
  static const tableShopOwner = "ShopOwner";
  static const colOwnerId = "ownerId";
  static const typeOfOwnerId = "TEXT NOT NULL";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colOwnerId: ownerId,
        colShopId: shopId,
      };

  static ShopOwner fromMap(Map<String, Object?> map) => ShopOwner(
        ownerId: map[colOwnerId] as String,
        shopId: map[colShopId] as String,
      );
}
