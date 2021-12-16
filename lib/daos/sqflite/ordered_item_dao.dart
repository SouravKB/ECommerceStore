import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/ordered_item.dart';
import 'package:sqflite/sqflite.dart';

class OrderedItemDao {
  OrderedItemDao._();

  static final instance = OrderedItemDao._();

  static const _tableOrderedItem = 'OrderedItem';

  Future<void> insertOrderedItem(OrderedItem orderedItem) async {
    await (await SqfliteDatabase.instance).insert(
        _tableOrderedItem, orderedItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteOrderedItem(String orderId, String productId) async {
    await (await SqfliteDatabase.instance).delete(_tableOrderedItem,
        where: 'orderId = ? AND productId = ?',
        whereArgs: [orderId, productId]);
  }

  Future<OrderedItem> getOrderedItem(String orderId, String productId) async {
    final result = await (await SqfliteDatabase.instance).query(
        _tableOrderedItem,
        where: 'orderId = ? AND productId = ?',
        whereArgs: [orderId, productId]);
    return OrderedItemSqfl.fromMap(result[0]);
  }

  Future<List<OrderedItem>> getOrderedItemList(String orderId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableOrderedItem, where: 'orderId = ?', whereArgs: [orderId]);
    return result
        .map((res) => OrderedItemSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE OrderedItem (
    orderId ${OrderedItemSqfl.typeOfOrderId},
    productId ${OrderedItemSqfl.typeOfProductId},
    count ${OrderedItemSqfl.typeOfCount},
    PRIMARY KEY(orderId, productId),
    FOREIGN KEY(orderId) REFERENCES Orderr(orderId),
    FOREIGN KEY(productId) REFERENCES Product(productId)
    )
    ''');
  }
}
