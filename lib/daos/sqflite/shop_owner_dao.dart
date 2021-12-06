import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/shop_owner.dart';
import 'package:sqflite/sqflite.dart';

class ShopOwnerDao {
  ShopOwnerDao._();

  static final instance = ShopOwnerDao._();

  static const _tableShopOwner = 'ShopOwner';

  void insertShopOwner(ShopOwner shopOwner) async {
    await (await SqfliteDatabase.instance).insert(
        _tableShopOwner, shopOwner.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteShopOwner(String ownerId, String shopId) async {
    await (await SqfliteDatabase.instance).delete(_tableShopOwner,
        where: 'ownerId = ? AND shopId = ?', whereArgs: [ownerId, shopId]);
  }

  Future<List<ShopOwner>> getShopOwnerList(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableShopOwner, where: 'shopId = ?', whereArgs: [shopId]);
    return result
        .map((res) => ShopOwnerSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE ShopOwner (
    ownerId ${ShopOwnerSqfl.typeOfOwnerId},
    shopId ${ShopOwnerSqfl.typeOfShopId},
    PRIMARY KEY(ownerId, shopId),
    FOREIGN KEY(ownerId) REFERENCES User(userId),
    FOREIGN KEY(shopId) REFERENCES Shop(shopId)
    )
    ''');
  }
}
