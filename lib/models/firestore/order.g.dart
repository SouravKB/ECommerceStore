// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension OrderCfs on Order {
  static const docOrder = "Order";
  static const keyOrderId = "orderId";
  static const keyShopId = "shopId";
  static const keyProducts = "products";
  static const keyPhoneNo = "phoneNo";
  static const keyAddress = "address";
  static const keyPayMethod = "payMethod";

  Map<String, Object?> toMap() => {
        keyOrderId: orderId,
        keyShopId: shopId,
        keyProducts: products,
        keyPhoneNo: phoneNo,
        keyAddress: address,
        keyPayMethod: payMethod,
      };

  static Order fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) =>
      Order(
        orderId: snap.id,
        shopId: snap[keyShopId] as String,
        products: snap[keyProducts] as Map<String, int>,
        phoneNo: snap[keyPhoneNo] as String,
        address: snap[keyAddress] as String,
        payMethod: snap[keyPayMethod] as String,
      );
}
