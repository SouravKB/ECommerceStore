import 'package:model_annotations/model_annotations.dart';

part 'shop.g.dart';

@SqflModel()
class Shop {
  final String shopId;
  final String name;
  final String? shopPicUrl;
  final String type;
  final String address;
  final String location;
  final int openTime;
  final int closeTime;
  final bool isOpenNow;

  Shop({
    required this.shopId,
    required this.name,
    required this.shopPicUrl,
    required this.type,
    required this.address,
    required this.location,
    required this.openTime,
    required this.closeTime,
    required this.isOpenNow,
  });
}
