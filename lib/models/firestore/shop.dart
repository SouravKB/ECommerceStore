import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

part 'shop.g.dart';

@CfsModel()
class Shop {
  @DocumentKey()
  final String shopId;
  final List<String> ownerIds;
  final String shopPic;
  final String category;
  final List<String> emailIds;
  final List<String> phoneNos;
  final String address;
  final int openTime;
  final int closeTime;
  final bool isOpen;
  final List<String> orderIds;

  Shop({
    required this.shopId,
    required this.ownerIds,
    required this.shopPic,
    required this.category,
    required this.emailIds,
    required this.phoneNos,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
    required this.orderIds,
  });
}
