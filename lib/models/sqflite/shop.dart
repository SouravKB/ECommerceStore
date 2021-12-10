import 'package:model_annotations/model_annotations.dart';

part 'shop.g.dart';

@SqflModel()
class Shop {
  final String shopId;
  final String name;
  final String? shopPicUrl;
  final String type;
  final String address;
  final DateTime openTime;
  final DateTime closeTime;
  final bool isCurrentlyOpen;

  Shop({
    required this.shopId,
    required this.name,
    required this.shopPicUrl,
    required this.type,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isCurrentlyOpen,
  });
}
