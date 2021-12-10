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

  Future<List<Product>> getProductList(String categoryId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableProduct, where: 'categoryId = ?', whereArgs: [categoryId]);
    return result
        .map((res) => ProductSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE Product (
    productId ${ProductSqfl.typeOfProductId} PRIMARY KEY,
    categoryId ${ProductSqfl.typeOfCategoryId},
    name ${ProductSqfl.typeOfName},
    imageUrl ${ProductSqfl.typeOfImageUrl},
    shortDesc ${ProductSqfl.typeOfShortDesc},
    price ${ProductSqfl.typeOfPrice},
    desc ${ProductSqfl.typeOfDesc},
    FOREIGN KEY(categoryId) REFERENCES Category(categoryId)
    )
    ''');
  }
}
