import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Shop {
  final String shopId;
  final List<String> ownerIds;
  final String name;
  final String? shopPicUrl;
  final String type;
  final List<String> phoneNos;
  final List<String> emailIds;
  final String address;
  final Location location;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final bool isOpenNow;

  Shop({
    required this.shopId,
    required this.ownerIds,
    required this.name,
    required this.shopPicUrl,
    required this.type,
    required this.phoneNos,
    required this.emailIds,
    required this.address,
    required this.location,
    required this.openTime,
    required this.closeTime,
    required this.isOpenNow,
  });
}
