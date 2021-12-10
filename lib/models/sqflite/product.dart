import 'package:model_annotations/model_annotations.dart';

part 'product.g.dart';

@SqflModel()
class Product {
  final String productId;
  final String categoryId;
  final String name;
  final String? imageUrl;
  final String shortDesc;
  final int price;
  final String desc;

  Product({
    required this.productId,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
    required this.shortDesc,
    required this.price,
    required this.desc,
  });
}
