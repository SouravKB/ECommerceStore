import 'package:ecommercestore/models/sqflite/shop.dart';
import 'package:ecommercestore/services/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

class ShopDao {
  ShopDao._();

  static final instance = ShopDao._();

  static const _tableShop = 'Shop';

  Future<void> insertShop(Shop shop) async {
    await (await SqfliteDatabase.instance).insert(_tableShop, shop.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteShop(String shopId) async {
    await (await SqfliteDatabase.instance)
        .delete(_tableShop, where: 'shopId = ?', whereArgs: [shopId]);
  }

  Future<Shop?> getShop(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableShop, where: 'shopId = ?', whereArgs: [shopId]);
    if (result.isEmpty) return null;
    return ShopSqfl.fromMap(result[0]);
  }

  Future<List<Shop>> getProductList() async {
    final result = await (await SqfliteDatabase.instance).query(_tableShop);
    return result.map((res) => ShopSqfl.fromMap(res)).toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE Shop (
    shopId ${ShopSqfl.typeOfShopId} PRIMARY KEY,
    name ${ShopSqfl.typeOfName},
    shopPicUrl ${ShopSqfl.typeOfShopPicUrl},
    type ${ShopSqfl.typeOfType},
    address ${ShopSqfl.typeOfAddress},
    location ${ShopSqfl.typeOfLocation},
    openTime ${ShopSqfl.typeOfOpenTime},
    closeTime ${ShopSqfl.typeOfCloseTime},
    isOpenNow ${ShopSqfl.typeOfIsOpenNow}
    )
    ''');
  }
}
