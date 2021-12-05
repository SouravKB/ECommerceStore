// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension CategoryCfs on Category {
  static const docCategory = "Category";
  static const keyCategoryId = "categoryId";
  static const keyName = "name";
  static const keyImageUrl = "imageUrl";

  Map<String, Object?> toMap() => {
        keyCategoryId: categoryId,
        keyName: name,
        keyImageUrl: imageUrl,
      };

  static Category fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) =>
      Category(
        categoryId: snap.id,
        name: snap[keyName] as String,
        imageUrl: snap[keyImageUrl] as String,
      );
}
