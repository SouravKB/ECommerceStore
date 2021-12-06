// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension CategorySqfl on Category {
  static const tableCategory = "Category";
  static const colCategoryId = "categoryId";
  static const typeOfCategoryId = "TEXT NOT NULL";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colName = "name";
  static const typeOfName = "TEXT NOT NULL";
  static const colImageUrl = "imageUrl";
  static const typeOfImageUrl = "TEXT";

  Map<String, Object?> toMap() => {
        colCategoryId: categoryId,
        colShopId: shopId,
        colName: name,
        colImageUrl: imageUrl,
      };

  static Category fromMap(Map<String, Object?> map) => Category(
        categoryId: map[colCategoryId] as String,
        shopId: map[colShopId] as String,
        name: map[colName] as String,
        imageUrl: map[colImageUrl] as String?,
      );
}
