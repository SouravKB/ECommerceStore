import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  CategoryDao._();

  static final instance = CategoryDao._();

  static const _tableCategory = 'Category';

  Future<void> insertCategory(Category category) async {
    await (await SqfliteDatabase.instance).insert(
        _tableCategory, category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCategory(String categoryId) async {
    await (await SqfliteDatabase.instance).delete(_tableCategory,
        where: 'categoryId = ?', whereArgs: [categoryId]);
  }

  Future<Category> getCategory(String categoryId) async {
    final result = await (await SqfliteDatabase.instance).query(_tableCategory,
        where: 'categoryId = ?', whereArgs: [categoryId]);
    return CategorySqfl.fromMap(result[0]);
  }

  Future<List<Category>> getCategoryList(String shopId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableCategory, where: 'shopId = ?', whereArgs: [shopId]);
    return result
        .map((res) => CategorySqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE Category (
    categoryId ${CategorySqfl.typeOfCategoryId} PRIMARY KEY,
    shopId ${CategorySqfl.typeOfShopId},
    name ${CategorySqfl.typeOfName},
    imageUrl ${CategorySqfl.typeOfImageUrl},
    FOREIGN KEY(shopId) REFERENCES Shop(shopId)
    )
    ''');
  }
}
