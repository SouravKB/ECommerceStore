import 'package:ecommercestore/daos/firestore/order_dao.dart' as firestore_daos;
import 'package:ecommercestore/daos/sqflite/order_dao.dart' as sqflite_daos;
import 'package:ecommercestore/daos/sqflite/ordered_item_dao.dart'
    as sqflite_daos;
import 'package:ecommercestore/models/firestore/order.dart' as firestore_models;
import 'package:ecommercestore/models/sqflite/order.dart' as sqflite_models;
import 'package:ecommercestore/models/sqflite/ordered_item.dart'
    as sqflite_models;
import 'package:ecommercestore/models/ui/order.dart';

class OrderRepo {
  OrderRepo._();

  static final instance = OrderRepo._();

  final _firestoreOrderDao = firestore_daos.OrderDao.instance;
  final _sqfliteOrderDao = sqflite_daos.OrderDao.instance;
  final _sqfliteOrderItemDao = sqflite_daos.OrderedItemDao.instance;

  Stream<List<Order>> getOrderListStreamForUser(String userId) async* {
    await for (final orders
        in _firestoreOrderDao.getOrderListStreamForUser(userId)) {
      for (final cfsOrder in orders) {
        final sqflOrder = sqflite_models.Order(
            orderId: cfsOrder.orderId,
            userId: cfsOrder.userId,
            shopId: cfsOrder.shopId,
            orderDateTime: cfsOrder.orderDateTime,
            phoneNo: cfsOrder.phoneNo,
            address: cfsOrder.address,
            price: cfsOrder.price,
            payMethod: cfsOrder.payMethod);
        _sqfliteOrderDao.insertOrder(sqflOrder);

        for (final item in cfsOrder.productIdsWithCount.entries) {
          final orderedItem = sqflite_models.OrderedItem(
              orderId: cfsOrder.orderId,
              productId: item.key,
              count: item.value);
          _sqfliteOrderItemDao.insertOrderedItem(orderedItem);
        }
      }

      yield orders
          .map((order) => Order(
              orderId: order.orderId,
              userId: order.userId,
              shopId: order.shopId,
              productIdsWithCount: order.productIdsWithCount,
              orderDateTime: order.orderDateTime,
              phoneNo: order.phoneNo,
              address: order.address,
              price: order.price,
              payMethod: PaymentMethod.values.firstWhere(
                  (method) => method.toString() == order.payMethod)))
          .toList(growable: false);
    }
  }

  Stream<List<Order>> getOrderListStreamForShop(String shopId) async* {
    await for (final orders
        in _firestoreOrderDao.getOrderListStreamForShop(shopId)) {
      for (final cfsOrder in orders) {
        final sqflOrder = sqflite_models.Order(
            orderId: cfsOrder.orderId,
            userId: cfsOrder.userId,
            shopId: cfsOrder.shopId,
            orderDateTime: cfsOrder.orderDateTime,
            phoneNo: cfsOrder.phoneNo,
            address: cfsOrder.address,
            price: cfsOrder.price,
            payMethod: cfsOrder.payMethod);
        _sqfliteOrderDao.insertOrder(sqflOrder);

        for (final item in cfsOrder.productIdsWithCount.entries) {
          final orderedItem = sqflite_models.OrderedItem(
              orderId: cfsOrder.orderId,
              productId: item.key,
              count: item.value);
          _sqfliteOrderItemDao.insertOrderedItem(orderedItem);
        }
      }

      yield orders
          .map((order) => Order(
              orderId: order.orderId,
              userId: order.userId,
              shopId: order.shopId,
              productIdsWithCount: order.productIdsWithCount,
              orderDateTime: order.orderDateTime,
              phoneNo: order.phoneNo,
              address: order.address,
              price: order.price,
              payMethod: PaymentMethod.values.firstWhere(
                  (method) => method.toString() == order.payMethod)))
          .toList(growable: false);
    }
  }

  Future<Order> getOrder(String orderId) async {
    final sqflOrder = await _sqfliteOrderDao.getOrder(orderId);
    if (sqflOrder != null) {
      final orderedItems =
          await _sqfliteOrderItemDao.getOrderedItemList(orderId);
      return Order(
        orderId: sqflOrder.orderId,
        userId: sqflOrder.userId,
        shopId: sqflOrder.shopId,
        productIdsWithCount: {
          for (final item in orderedItems) item.productId: item.count
        },
        orderDateTime: sqflOrder.orderDateTime,
        phoneNo: sqflOrder.phoneNo,
        address: sqflOrder.address,
        price: sqflOrder.price,
        payMethod: PaymentMethod.values
            .firstWhere((method) => method.toString() == sqflOrder.payMethod),
      );
    } else {
      final cfsOrder = await _firestoreOrderDao.getOrder(orderId);
      final sqflOrder = sqflite_models.Order(
          orderId: cfsOrder.orderId,
          userId: cfsOrder.userId,
          shopId: cfsOrder.shopId,
          orderDateTime: cfsOrder.orderDateTime,
          phoneNo: cfsOrder.phoneNo,
          address: cfsOrder.address,
          price: cfsOrder.price,
          payMethod: cfsOrder.payMethod);
      _sqfliteOrderDao.insertOrder(sqflOrder);

      for (final item in cfsOrder.productIdsWithCount.entries) {
        final orderedItem = sqflite_models.OrderedItem(
            orderId: cfsOrder.orderId, productId: item.key, count: item.value);
        _sqfliteOrderItemDao.insertOrderedItem(orderedItem);
      }

      return Order(
        orderId: cfsOrder.orderId,
        userId: cfsOrder.userId,
        shopId: cfsOrder.shopId,
        productIdsWithCount: cfsOrder.productIdsWithCount,
        orderDateTime: cfsOrder.orderDateTime,
        phoneNo: cfsOrder.phoneNo,
        address: cfsOrder.address,
        price: cfsOrder.price,
        payMethod: PaymentMethod.values
            .firstWhere((method) => method.toString() == sqflOrder.payMethod),
      );
    }
  }

  Future<void> addOrder(Order order) async {
    final cfsOrder = firestore_models.Order(
        orderId: order.orderId,
        userId: order.userId,
        shopId: order.shopId,
        productIdsWithCount: order.productIdsWithCount,
        orderDateTime: order.orderDateTime,
        phoneNo: order.phoneNo,
        address: order.address,
        price: order.price,
        payMethod: order.payMethod.toString());
    await _firestoreOrderDao.addOrder(cfsOrder);
  }
}
