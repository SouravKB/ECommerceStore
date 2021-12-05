// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension OrderSqfl on Order {
  static const tableOrder = "Order";
  static const colOrderId = "orderId";
  static const typeOfOrderId = "TEXT NOT NULL";
  static const colUserId = "userId";
  static const typeOfUserId = "TEXT NOT NULL";
  static const colShopId = "shopId";
  static const typeOfShopId = "TEXT NOT NULL";
  static const colPhoneNo = "phoneNo";
  static const typeOfPhoneNo = "TEXT NOT NULL";
  static const colAddress = "address";
  static const typeOfAddress = "TEXT NOT NULL";
  static const colPayMethod = "payMethod";
  static const typeOfPayMethod = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colOrderId: orderId,
        colUserId: userId,
        colShopId: shopId,
        colPhoneNo: phoneNo,
        colAddress: address,
        colPayMethod: payMethod,
      };

  static Order fromMap(Map<String, Object?> map) => Order(
        orderId: map[colOrderId] as String,
        userId: map[colUserId] as String,
        shopId: map[colShopId] as String,
        phoneNo: map[colPhoneNo] as String,
        address: map[colAddress] as String,
        payMethod: map[colPayMethod] as String,
      );
}
