import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/category.dart';

class CategoryDao {
  CategoryDao._();

  static final instance = CategoryDao._();

  static const _keyShops = 'shops';
  static const _keyCategories = 'categories';

  CollectionReference<Category> _getCategoryColReference(String shopId) {
    return FirebaseFirestore.instance
        .collection(_keyShops)
        .doc(shopId)
        .collection(_keyCategories)
        .withConverter<Category>(
          fromFirestore: (snap, _) => CategoryCfs.fromSnapshot(snap),
          toFirestore: (category, _) => category.toMap(),
        );
  }

  DocumentReference<Category> _getCategoryReference(
      String shopId, String categoryId) {
    return _getCategoryColReference(shopId).doc(categoryId);
  }

  Future<String> addCategory(String shopId, Category category) async {
    final doc = await _getCategoryColReference(shopId).add(category);
    return doc.id;
  }

  void setCategory(String shopId, Category category) async {
    await _getCategoryReference(shopId, category.categoryId).set(category);
  }

  void deleteCategory(String shopId, String categoryId) async {
    await _getCategoryReference(shopId, categoryId).delete();
  }

  Future<Category> getCategory(String shopId, String categoryId) async {
    final doc = await _getCategoryReference(shopId, categoryId).get();
    return doc.data()!;
  }

  Future<List<Category>> getCategoryList(String shopId) async {
    final querySnap = await _getCategoryColReference(shopId).get();
    final categoryList = <Category>[];
    for (final doc in querySnap.docs) {
      categoryList.add(doc.data());
    }
    return categoryList;
  }
}
