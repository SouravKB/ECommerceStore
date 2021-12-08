import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/order.dart';

class OrderDao {
  OrderDao._();

  static final instance = OrderDao._();

  static const _keyOrders = 'orders';

  CollectionReference<Order> _getOrderColReference() {
    return FirebaseFirestore.instance
        .collection(_keyOrders)
        .withConverter<Order>(
          fromFirestore: (snap, _) => OrderCfs.fromSnapshot(snap),
          toFirestore: (order, _) => order.toMap(),
        );
  }

  DocumentReference<Order> getOrderReference(String orderId) {
    return _getOrderColReference().doc(orderId);
  }

  Query<Order> _getUserOrdersQuery(String userId) {
    return FirebaseFirestore.instance
        .collection(_keyOrders)
        .where('userId', isEqualTo: userId)
        .withConverter<Order>(
          fromFirestore: (snap, _) => OrderCfs.fromSnapshot(snap),
          toFirestore: (order, _) => order.toMap(),
        );
  }

  Query<Order> _getShopOrdersQuery(String shopId) {
    return FirebaseFirestore.instance
        .collection(_keyOrders)
        .where('shopId', isEqualTo: shopId)
        .withConverter<Order>(
          fromFirestore: (snap, _) => OrderCfs.fromSnapshot(snap),
          toFirestore: (order, _) => order.toMap(),
        );
  }

  Future<String> addOrder(Order order) async {
    final doc = await _getOrderColReference().add(order);
    return doc.id;
  }

  Future<void> setOrder(Order order) async {
    await getOrderReference(order.orderId).set(order);
  }

  Future<void> deleteOrder(String orderId) async {
    await getOrderReference(orderId).delete();
  }

  Future<Order> getOrder(String orderId) async {
    final doc = await getOrderReference(orderId).get();
    return doc.data()!;
  }

  Future<List<Order>> getOrderListForUser(String userId) async {
    final querySnap = await _getUserOrdersQuery(userId).get();
    final orderList = <Order>[];
    for (final doc in querySnap.docs) {
      orderList.add(doc.data());
    }
    return orderList;
  }

  Future<List<Order>> getOrderListForShop(String shopId) async {
    final querySnap = await _getShopOrdersQuery(shopId).get();
    final orderList = <Order>[];
    for (final doc in querySnap.docs) {
      orderList.add(doc.data());
    }
    return orderList;
  }
}
