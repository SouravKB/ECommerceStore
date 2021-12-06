import 'package:model_annotations/model_annotations.dart';

part 'shop.g.dart';

@SqflModel()
class Shop {
  final String shopId;
  final String? shopPicUrl;
  final String type;
  final String address;
  final int openTime;
  final int closeTime;
  final bool isOpen;

  Shop({
    required this.shopId,
    required this.shopPicUrl,
    required this.type,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
  });
}
