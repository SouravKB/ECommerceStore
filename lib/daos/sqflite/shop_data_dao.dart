import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/shop_data.dart';
import 'package:sqflite/sqflite.dart';

class ShopDataDao {
  ShopDataDao._();

  static final instance = ShopDataDao._();

  static const _tableShopData = 'ShopData';

  Future<void> insertShopData(ShopData shopData) async {
    await (await SqfliteDatabase.instance).insert(
        _tableShopData, shopData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteShopData(ShopData shopData) async {
    await (await SqfliteDatabase.instance).delete(_tableShopData,
        where: 'shopId = ? AND data = ? AND type = ?',
        whereArgs: [shopData.shopId, shopData.data, shopData.type]);
  }

  Future<List<ShopData>> getShopDataList(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableShopData, where: 'shopId = ?', whereArgs: [shopId]);
    return result
        .map((res) => ShopDataSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE ShopData (
    shopId ${ShopDataSqfl.typeOfShopId},
    data ${ShopDataSqfl.typeOfData},
    type ${ShopDataSqfl.typeOfType},
    FOREIGN KEY(shopId) REFERENCES Shop(shopId)
    )
    ''');
  }
}
