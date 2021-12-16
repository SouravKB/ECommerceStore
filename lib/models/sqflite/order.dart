import 'package:model_annotations/model_annotations.dart';

part 'order.g.dart';

@SqflModel()
class Order {
  final String orderId;
  final String userId;
  final String shopId;
  final DateTime orderDateTime;
  final String phoneNo;
  final String address;
  final int price;
  final String payMethod;

  Order({
    required this.orderId,
    required this.userId,
    required this.shopId,
    required this.orderDateTime,
    required this.phoneNo,
    required this.address,
    required this.price,
    required this.payMethod,
  });
}
