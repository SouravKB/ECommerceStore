import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductDao {
  ProductDao._();

  static final instance = ProductDao._();

  static const _tableProduct = 'Product';

  Future<void> insertProduct(Product product) async {
    await (await SqfliteDatabase.instance).insert(
        _tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteProduct(String productId) async {
    await (await SqfliteDatabase.instance)
        .delete(_tableProduct, where: 'productId = ?', whereArgs: [productId]);
  }

  Future<Product> getProduct(String productId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableProduct, where: 'productId = ?', whereArgs: [productId]);
    return ProductSqfl.fromMap(result[0]);
  }

  Future<List<Product>> getProductList(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableProduct, where: 'shopId = ?', whereArgs: [shopId]);
    return result
        .map((res) => ProductSqfl.fromMap(res))
        .toList(growable: false);
  }

  Future<List<String>> getCategories(String shopId) async {
    final result = await (await SqfliteDatabase.instance).query(_tableProduct,
        columns: ['category'],
        where: 'shopId = ?',
        whereArgs: [shopId],
        groupBy: 'category');
    return result
        .map((res) => res['category'] as String)
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE Product (
    productId ${ProductSqfl.typeOfProductId} PRIMARY KEY,
    shopId ${ProductSqfl.typeOfShopId},
    name ${ProductSqfl.typeOfName},
    imageUrl ${ProductSqfl.typeOfImageUrl},
    shortDesc ${ProductSqfl.typeOfShortDesc},
    category ${ProductSqfl.typeOfCategory},
    price ${ProductSqfl.typeOfPrice},
    desc ${ProductSqfl.typeOfDesc},
    FOREIGN KEY(shopId) REFERENCES Shop(shopId)
    )
    ''');
  }
}
