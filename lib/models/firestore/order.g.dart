// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension OrderCfs on Order {
  static const docOrder = "Order";
  static const keyOrderId = "orderId";
  static const keyUserId = "userId";
  static const keyShopId = "shopId";
  static const keyProductIdsWithCount = "productIdsWithCount";
  static const keyOrderDateTime = "orderDateTime";
  static const keyPhoneNo = "phoneNo";
  static const keyAddress = "address";
  static const keyPrice = "price";
  static const keyPayMethod = "payMethod";

  Map<String, Object?> toMap() => {
        keyOrderId: orderId,
        keyUserId: userId,
        keyShopId: shopId,
        keyProductIdsWithCount: productIdsWithCount,
        keyOrderDateTime: orderDateTime,
        keyPhoneNo: phoneNo,
        keyAddress: address,
        keyPrice: price,
        keyPayMethod: payMethod,
      };

  static Order fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) {
    log(snap.data().toString());
    return Order(
      orderId: snap.id,
      userId: snap[keyUserId] as String,
      shopId: snap[keyShopId] as String,
      productIdsWithCount: (snap[keyProductIdsWithCount] as Map)
          .map((key, value) => MapEntry(key, (value as num).toInt())),
      orderDateTime: (snap[keyOrderDateTime] as Timestamp).toDate(),
      phoneNo: snap[keyPhoneNo] as String,
      address: snap[keyAddress] as String,
      price: (snap[keyPrice] as num).toInt(),
      payMethod: snap[keyPayMethod] as String,
    );
  }
}
