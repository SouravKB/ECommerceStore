import 'package:model_builder/model_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'order.g.dart';

@CfsModel()
class Order {
  @DocumentKey()
  final String orderId;
  final Map<String, int> products;
  final String phoneNo;
  final String address;
  final String payMethod;

  Order({
    required this.orderId,
    required this.products,
    required this.phoneNo,
    required this.address,
    required this.payMethod,
  });
}
