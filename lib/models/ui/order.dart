class Order {
  final String orderId;
  final String userId;
  final String shopId;
  final Map<String, int> productIdsWithCount;
  final DateTime orderDateTime;
  final String phoneNo;
  final String address;
  final PaymentMethod payMethod;

  Order({
    required this.orderId,
    required this.userId,
    required this.shopId,
    required this.productIdsWithCount,
    required this.orderDateTime,
    required this.phoneNo,
    required this.address,
    required this.payMethod,
  });
}

enum PaymentMethod { cash, upi }
