import 'package:ecommercestore/daos/firestore/category_dao.dart'
    as firestore_daos;
import 'package:ecommercestore/daos/sqflite/category_dao.dart' as sqflite_daos;
import 'package:ecommercestore/models/firestore/category.dart'
    as firestore_models;
import 'package:ecommercestore/models/sqflite/category.dart' as sqflite_models;
import 'package:ecommercestore/models/ui/category.dart';

class CategoryRepo {
  CategoryRepo._();

  static final instance = CategoryRepo._();

  final _firestoreCategoryDao = firestore_daos.CategoryDao.instance;
  final _sqfliteCategoryDao = sqflite_daos.CategoryDao.instance;

  Stream<List<Category>> getCategoryListStream(String shopId) async* {
    await for (final categories
        in _firestoreCategoryDao.getCategoryListStream(shopId)) {
      for (final cfsCategory in categories) {
        final sqflCategory = sqflite_models.Category(
            categoryId: cfsCategory.categoryId,
            shopId: shopId,
            name: cfsCategory.name,
            imageUrl: cfsCategory.imageUrl);
        _sqfliteCategoryDao.insertCategory(sqflCategory);
      }

      yield categories
          .map((category) => Category(
              categoryId: category.categoryId,
              name: category.name,
              imageUrl: category.imageUrl))
          .toList(growable: false);
    }
  }

  Stream<Category> getCategoryStream(String shopId, String categoryId) async* {
    await for (final cfsCategory
        in _firestoreCategoryDao.getCategoryStream(shopId, categoryId)) {
      final sqflCategory = sqflite_models.Category(
          categoryId: cfsCategory.categoryId,
          shopId: shopId,
          name: cfsCategory.name,
          imageUrl: cfsCategory.imageUrl);
      _sqfliteCategoryDao.insertCategory(sqflCategory);

      yield Category(
          categoryId: cfsCategory.categoryId,
          name: cfsCategory.name,
          imageUrl: cfsCategory.imageUrl);
    }
  }

  Future<void> addCategory(String shopId, Category category) async {
    final cfsCategory = firestore_models.Category(
        categoryId: category.categoryId,
        name: category.name,
        imageUrl: category.imageUrl);
    await _firestoreCategoryDao.addCategory(shopId, cfsCategory);
  }

  Future<void> updateCategory(String shopId, Category category) async {
    final cfsCategory = firestore_models.Category(
        categoryId: category.categoryId,
        name: category.name,
        imageUrl: category.imageUrl);
    await _firestoreCategoryDao.setCategory(shopId, cfsCategory);
  }

  Future<void> deleteCategory(String shopId, String categoryId) async {
    await _firestoreCategoryDao.deleteCategory(shopId, categoryId);
  }
}
