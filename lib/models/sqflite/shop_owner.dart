import 'package:model_annotations/model_annotations.dart';

part 'shop_owner.g.dart';

@SqflModel()
class ShopOwner {
  final String ownerId;
  final String shopId;

  ShopOwner({
    required this.ownerId,
    required this.shopId,
  });
}
