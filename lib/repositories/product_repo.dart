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

  Stream<List<Product>> getProductListStream(
      String shopId, String categoryId) async* {
    await for (final products
        in _firestoreProductDao.getProductListStream(shopId, categoryId)) {
      for (final cfsProduct in products) {
        final sqflProduct = sqflite_models.Product(
            productId: cfsProduct.productId,
            categoryId: categoryId,
            name: cfsProduct.name,
            imageUrl: cfsProduct.imageUrl,
            shortDesc: cfsProduct.shortDesc,
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
              price: product.price,
              desc: product.desc))
          .toList(growable: false);
    }
  }

  Stream<Product> getProductStream(
      String shopId, String categoryId, String productId) async* {
    await for (final cfsProduct in _firestoreProductDao.getProductStream(
        shopId, categoryId, productId)) {
      final sqflProduct = sqflite_models.Product(
          productId: cfsProduct.productId,
          categoryId: categoryId,
          name: cfsProduct.name,
          imageUrl: cfsProduct.imageUrl,
          shortDesc: cfsProduct.shortDesc,
          price: cfsProduct.price,
          desc: cfsProduct.desc);
      _sqfliteProductDao.insertProduct(sqflProduct);

      yield Product(
          productId: cfsProduct.productId,
          name: cfsProduct.name,
          imageUrl: cfsProduct.imageUrl,
          shortDesc: cfsProduct.shortDesc,
          price: cfsProduct.price,
          desc: cfsProduct.desc);
    }
  }

  Future<void> addProduct(
      String shopId, String categoryId, Product product) async {
    final cfsProduct = firestore_models.Product(
        productId: product.productId,
        name: product.name,
        imageUrl: product.imageUrl,
        shortDesc: product.shortDesc,
        price: product.price,
        desc: product.desc);
    await _firestoreProductDao.addProduct(shopId, categoryId, cfsProduct);
  }

  Future<void> updateProduct(
      String shopId, String categoryId, Product product) async {
    final cfsProduct = firestore_models.Product(
        productId: product.productId,
        name: product.name,
        imageUrl: product.imageUrl,
        shortDesc: product.shortDesc,
        price: product.price,
        desc: product.desc);
    await _firestoreProductDao.setProduct(shopId, categoryId, cfsProduct);
  }

  Future<void> deleteProduct(
      String shopId, String categoryId, String productId) async {
    await _firestoreProductDao.deleteProduct(shopId, categoryId, productId);
  }
}
