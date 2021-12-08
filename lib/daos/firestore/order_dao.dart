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

  Future<void> deleteOrder(String orderId) async {
    await getOrderReference(orderId).delete();
  }

  Stream<List<Order>> getOrderListStreamForUser(String userId) {
    return _getUserOrdersQuery(userId).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }

  Stream<List<Order>> getOrderListStreamForShop(String shopId) {
    return _getShopOrdersQuery(shopId).snapshots().map(
        (snap) => snap.docs.map((doc) => doc.data()).toList(growable: false));
  }
}
