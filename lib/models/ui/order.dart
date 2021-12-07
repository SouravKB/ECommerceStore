class Order {
  final String orderId;
  final Map<String, int> products;
  final String phoneNo;
  final String address;
  final PaymentMethod payMethod;

  Order({
    required this.orderId,
    required this.products,
    required this.phoneNo,
    required this.address,
    required this.payMethod,
  });
}

enum PaymentMethod { cash, upi }
