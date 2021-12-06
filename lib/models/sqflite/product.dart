import 'package:model_annotations/model_annotations.dart';

part 'product.g.dart';

@SqflModel()
class Product {
  final String productId;
  final String categoryId;
  final String brand;
  final String? imageUrl;
  final int count;
  final String netQty;
  final int cost;
  final String desc;

  Product({
    required this.productId,
    required this.categoryId,
    required this.brand,
    required this.imageUrl,
    required this.count,
    required this.netQty,
    required this.cost,
    required this.desc,
  });
}
