// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension ProductCfs on Product {
  static const docProduct = "Product";
  static const keyProductId = "productId";
  static const keyName = "name";
  static const keyImageUrl = "imageUrl";
  static const keyShortDesc = "shortDesc";
  static const keyPrice = "price";
  static const keyDesc = "desc";

  Map<String, Object?> toMap() => {
        keyProductId: productId,
        keyName: name,
        keyImageUrl: imageUrl,
        keyShortDesc: shortDesc,
        keyPrice: price,
        keyDesc: desc,
      };

  static Product fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) =>
      Product(
        productId: snap.id,
        name: snap[keyName] as String,
        imageUrl: snap[keyImageUrl] as String?,
        shortDesc: snap[keyShortDesc] as String,
        price: (snap[keyPrice] as num).toInt(),
        desc: snap[keyDesc] as String,
      );
}
