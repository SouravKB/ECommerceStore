// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_item.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension OrderedItemSqfl on OrderedItem {
  static const tableOrderedItem = "OrderedItem";
  static const colOrderId = "orderId";
  static const typeOfOrderId = "TEXT NOT NULL";
  static const colProductId = "productId";
  static const typeOfProductId = "TEXT NOT NULL";
  static const colCount = "count";
  static const typeOfCount = "INTEGER NOT NULL";

  Map<String, Object?> toMap() => {
        colOrderId: orderId,
        colProductId: productId,
        colCount: count,
      };

  static OrderedItem fromMap(Map<String, Object?> map) => OrderedItem(
        orderId: map[colOrderId] as String,
        productId: map[colProductId] as String,
        count: map[colCount] as int,
      );
}
