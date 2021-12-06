import 'package:model_annotations/model_annotations.dart';

part 'shop_data.g.dart';

@SqflModel()
class ShopData {
  final String shopId;
  final String data;
  final String type;

  ShopData({
    required this.shopId,
    required this.data,
    required this.type,
  });
}
