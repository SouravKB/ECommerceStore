import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/order.dart';
import 'package:sqflite/sqflite.dart';

class OrderDao {
  OrderDao._();

  static final instance = OrderDao._();

  static const _tableOrder = 'Order';

  Future<void> insertOrder(Order order) async {
    await (await SqfliteDatabase.instance).insert(_tableOrder, order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteOrder(String orderId) async {
    await (await SqfliteDatabase.instance)
        .delete(_tableOrder, where: 'orderId = ?', whereArgs: [orderId]);
  }

  Future<Order> getOrder(String orderId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableOrder, where: 'orderId = ?', whereArgs: [orderId]);
    return OrderSqfl.fromMap(result[0]);
  }

  Future<List<Order>> getOrderListForShop(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableOrder, where: 'shopId = ?', whereArgs: [shopId]);
    return result.map((res) => OrderSqfl.fromMap(res)).toList(growable: false);
  }

  Future<List<Order>> getOrderListForUser(String userId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableOrder, where: 'userId = ?', whereArgs: [userId]);
    return result.map((res) => OrderSqfl.fromMap(res)).toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE Order (
    orderId ${OrderSqfl.typeOfOrderId} PRIMARY KEY,
    userId ${OrderSqfl.typeOfUserId},
    shopId ${OrderSqfl.typeOfShopId},
    orderDateTime ${OrderSqfl.typeOfOrderDateTime},
    phoneNo ${OrderSqfl.typeOfPhoneNo},
    address ${OrderSqfl.typeOfAddress},
    payMethod ${OrderSqfl.typeOfPayMethod},
    FOREIGN KEY(userId) REFERENCES User(userId),
    FOREIGN KEY(shopId) REFERENCES Shop(shopId)
    )
    ''');
  }
}
