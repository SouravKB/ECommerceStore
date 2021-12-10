import 'package:ecommercestore/daos/firestore/product_dao.dart'
    as firestore_daos;
import 'package:ecommercestore/daos/sqflite/product_dao.dart' as sqflite_daos;
import 'package:ecommercestore/models/firestore/product.dart'
    as firestore_models;
import 'package:ecommercestore/models/sqflite/product.dart' as sqflite_models;
import 'package:ecommercestore/models/ui/product.dart';

class ProductRepo {
  ProductRepo._();

  static final instance = ProductRepo._();

  final _firestoreProductDao = firestore_daos.ProductDao.instance;
  final _sqfliteProductDao = sqflite_daos.ProductDao.instance;

  Stream<List<Product>> getProductListStream(String shopId) async* {
    await for (final products
        in _firestoreProductDao.getProductListStream(shopId)) {
      for (final cfsProduct in products) {
        final sqflProduct = sqflite_models.Product(
            productId: cfsProduct.productId,
            shopId: shopId,
            name: cfsProduct.name,
            imageUrl: cfsProduct.imageUrl,
            shortDesc: cfsProduct.shortDesc,
            category: cfsProduct.category,
            price: cfsProduct.price,
            desc: cfsProduct.desc);
        _sqfliteProductDao.insertProduct(sqflProduct);
      }

      yield products
          .map((product) => Product(
              productId: product.productId,
              name: product.name,
              imageUrl: product.imageUrl,
              shortDesc: product.shortDesc,
              category: product.category,
              price: product.price,
              desc: product.desc))
          .toList(growable: false);
    }
  }

  Stream<Product> getProductStream(String shopId, String productId) async* {
    await for (final cfsProduct
        in _firestoreProductDao.getProductStream(shopId, productId)) {
      final sqflProduct = sqflite_models.Product(
          productId: cfsProduct.productId,
          shopId: shopId,
          name: cfsProduct.name,
          imageUrl: cfsProduct.imageUrl,
          shortDesc: cfsProduct.shortDesc,
          category: cfsProduct.category,
          price: cfsProduct.price,
          desc: cfsProduct.desc);
      _sqfliteProductDao.insertProduct(sqflProduct);

      yield Product(
          productId: cfsProduct.productId,
          name: cfsProduct.name,
          imageUrl: cfsProduct.imageUrl,
          shortDesc: cfsProduct.shortDesc,
          category: cfsProduct.category,
          price: cfsProduct.price,
          desc: cfsProduct.desc);
    }
  }

  Stream<List<String>> getCategoriesStream(String shopId) async* {
    await for (final _ in getProductListStream(shopId)) {
      yield await _sqfliteProductDao.getCategories(shopId);
    }
  }

  Future<void> addProduct(String shopId, Product product) async {
    final cfsProduct = firestore_models.Product(
        productId: product.productId,
        name: product.name,
        imageUrl: product.imageUrl,
        shortDesc: product.shortDesc,
        category: product.category,
        price: product.price,
        desc: product.desc);
    await _firestoreProductDao.addProduct(shopId, cfsProduct);
  }

  Future<void> updateProduct(String shopId, Product product) async {
    final cfsProduct = firestore_models.Product(
        productId: product.productId,
        name: product.name,
        imageUrl: product.imageUrl,
        shortDesc: product.shortDesc,
        category: product.category,
        price: product.price,
        desc: product.desc);
    await _firestoreProductDao.setProduct(shopId, cfsProduct);
  }

  Future<void> deleteProduct(String shopId, String productId) async {
    await _firestoreProductDao.deleteProduct(shopId, productId);
  }
}
