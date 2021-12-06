// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension ProductSqfl on Product {
  static const tableProduct = "Product";
  static const colProductId = "productId";
  static const typeOfProductId = "TEXT NOT NULL";
  static const colCategoryId = "categoryId";
  static const typeOfCategoryId = "TEXT NOT NULL";
  static const colBrand = "brand";
  static const typeOfBrand = "TEXT NOT NULL";
  static const colImageUrl = "imageUrl";
  static const typeOfImageUrl = "TEXT";
  static const colCount = "count";
  static const typeOfCount = "INTEGER NOT NULL";
  static const colNetQty = "netQty";
  static const typeOfNetQty = "TEXT NOT NULL";
  static const colCost = "cost";
  static const typeOfCost = "INTEGER NOT NULL";
  static const colDesc = "desc";
  static const typeOfDesc = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colProductId: productId,
        colCategoryId: categoryId,
        colBrand: brand,
        colImageUrl: imageUrl,
        colCount: count,
        colNetQty: netQty,
        colCost: cost,
        colDesc: desc,
      };

  static Product fromMap(Map<String, Object?> map) => Product(
        productId: map[colProductId] as String,
        categoryId: map[colCategoryId] as String,
        brand: map[colBrand] as String,
        imageUrl: map[colImageUrl] as String?,
        count: map[colCount] as int,
        netQty: map[colNetQty] as String,
        cost: map[colCost] as int,
        desc: map[colDesc] as String,
      );
}
