// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ProductSqfl on Product {
  static const tableProduct = "Product";
  static const colProductId = "productId";
  static const typeOfProductId = "TEXT NOT NULL";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colName = "name";
  static const typeOfName = "TEXT NOT NULL";
  static const colImageUrl = "imageUrl";
  static const typeOfImageUrl = "TEXT";
  static const colShortDesc = "shortDesc";
  static const typeOfShortDesc = "TEXT NOT NULL";
  static const colCategory = "category";
  static const typeOfCategory = "TEXT NOT NULL";
  static const colPrice = "price";
  static const typeOfPrice = "INTEGER NOT NULL";
  static const colDesc = "desc";
  static const typeOfDesc = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colProductId: productId,
        colShopId: shopId,
        colName: name,
        colImageUrl: imageUrl,
        colShortDesc: shortDesc,
        colCategory: category,
        colPrice: price,
        colDesc: desc,
      };

  static Product fromMap(Map<String, Object?> map) => Product(
        productId: map[colProductId] as String,
        shopId: map[colShopId] as String,
        name: map[colName] as String,
        imageUrl: map[colImageUrl] as String?,
        shortDesc: map[colShortDesc] as String,
        category: map[colCategory] as String,
        price: map[colPrice] as int,
        desc: map[colDesc] as String,
      );
}
