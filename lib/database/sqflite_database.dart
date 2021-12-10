import 'dart:async';

import 'package:ecommercestore/daos/sqflite/order_dao.dart';
import 'package:ecommercestore/daos/sqflite/ordered_item_dao.dart';
import 'package:ecommercestore/daos/sqflite/product_dao.dart';
import 'package:ecommercestore/daos/sqflite/shop_dao.dart';
import 'package:ecommercestore/daos/sqflite/shop_data_dao.dart';
import 'package:ecommercestore/daos/sqflite/shop_owner_dao.dart';
import 'package:ecommercestore/daos/sqflite/user_dao.dart';
import 'package:ecommercestore/daos/sqflite/user_data_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'ecommercestore.db'),
      version: 1,
      onCreate: (db, version) => _createDatabase(db, version),
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    switch (version) {
      case 1:
        await UserDao.createTable(db);
        await UserDataDao.createTable(db);
        await ShopDao.createTable(db);
        await ShopDataDao.createTable(db);
        await ShopOwnerDao.createTable(db);
        await ProductDao.createTable(db);
        await OrderDao.createTable(db);
        await OrderedItemDao.createTable(db);
        return;
    }
  }

  static final instance = _initDatabase();
}
