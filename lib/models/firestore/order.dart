import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

part 'order.g.dart';

@CfsModel()
class Order {
  @DocumentKey()
  final String orderId;
  final String userId;
  final String shopId;
  final Map<String, int> products;
  final String phoneNo;
  final String address;
  final String payMethod;

  Order({
    required this.orderId,
    required this.userId,
    required this.shopId,
    required this.products,
    required this.phoneNo,
    required this.address,
    required this.payMethod,
  });
}
