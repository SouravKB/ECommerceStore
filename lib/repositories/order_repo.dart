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
            phoneNo: cfsOrder.phoneNo,
            address: cfsOrder.address,
            payMethod: cfsOrder.payMethod);
        _sqfliteOrderDao.insertOrder(sqflOrder);

        for (final item in cfsOrder.products.entries) {
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
              products: order.products,
              phoneNo: order.phoneNo,
              address: order.address,
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
            phoneNo: cfsOrder.phoneNo,
            address: cfsOrder.address,
            payMethod: cfsOrder.payMethod);
        _sqfliteOrderDao.insertOrder(sqflOrder);

        for (final item in cfsOrder.products.entries) {
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
              products: order.products,
              phoneNo: order.phoneNo,
              address: order.address,
              payMethod: PaymentMethod.values.firstWhere(
                  (method) => method.toString() == order.payMethod)))
          .toList(growable: false);
    }
  }

  Future<void> addOrder(Order order) async {
    final cfsOrder = firestore_models.Order(
        orderId: order.orderId,
        userId: order.userId,
        shopId: order.shopId,
        products: order.products,
        phoneNo: order.phoneNo,
        address: order.address,
        payMethod: order.payMethod.toString());
    await _firestoreOrderDao.addOrder(cfsOrder);
  }

  Future<void> deleteOrder(String orderId) async {
    await _firestoreOrderDao.deleteOrder(orderId);
  }
}
