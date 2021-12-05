import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/order.dart';

class OrderDao {
  OrderDao._();

  static final instance = OrderDao._();

  static const _keyUsers = 'users';
  static const _keyOrders = 'orders';

  CollectionReference<Order> _getOrderColReference(String userId) {
    return FirebaseFirestore.instance
        .collection(_keyUsers)
        .doc(userId)
        .collection(_keyOrders)
        .withConverter<Order>(
          fromFirestore: (snap, _) => OrderCfs.fromSnapshot(snap),
          toFirestore: (order, _) => order.toMap(),
        );
  }

  DocumentReference<Order> getOrderReference(String userId, String orderId) {
    return _getOrderColReference(userId).doc(orderId);
  }

  Future<String> addOrder(String userId, Order order) async {
    final doc = await _getOrderColReference(userId).add(order);
    return doc.id;
  }

  void setOrder(String userId, Order order) async {
    await getOrderReference(userId, order.orderId).set(order);
  }

  void deleteOrder(String userId, String orderId) async {
    await getOrderReference(userId, orderId).delete();
  }

  Future<Order> getOrder(String userId, String orderId) async {
    final doc = await getOrderReference(userId, orderId).get();
    return doc.data()!;
  }

  Future<List<Order>> getOrderList(String userId) async {
    final querySnap = await _getOrderColReference(userId).get();
    final orderList = <Order>[];
    for (final doc in querySnap.docs) {
      orderList.add(doc.data());
    }
    return orderList;
  }
}
