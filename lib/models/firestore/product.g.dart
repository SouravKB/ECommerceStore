// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension ProductCfs on Product {
  static const docProduct = "Product";
  static const keyProductId = "productId";
  static const keyBrand = "brand";
  static const keyImageUrl = "imageUrl";
  static const keyCount = "count";
  static const keyNetQty = "netQty";
  static const keyCost = "cost";
  static const keyDesc = "desc";

  Map<String, Object?> toMap() => {
        keyProductId: productId,
        keyBrand: brand,
        keyImageUrl: imageUrl,
        keyCount: count,
        keyNetQty: netQty,
        keyCost: cost,
        keyDesc: desc,
      };

  static Product fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) =>
      Product(
        productId: snap.id,
        brand: snap[keyBrand] as String,
        imageUrl: snap[keyImageUrl] as String?,
        count: snap[keyCount] as double,
        netQty: snap[keyNetQty] as double,
        cost: snap[keyCost] as int,
        desc: snap[keyDesc] as String,
      );
}
