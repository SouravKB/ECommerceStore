import 'package:model_annotations/model_annotations.dart';

part 'ordered_item.g.dart';

@SqflModel()
class OrderedItem {
  final String orderId;
  final String productId;
  final int count;

  OrderedItem({
    required this.orderId,
    required this.productId,
    required this.count,
  });
}
