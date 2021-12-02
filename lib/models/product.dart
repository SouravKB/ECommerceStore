import 'package:model_builder/model_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product.g.dart';

@CfsModel()
class Product {
  @DocumentKey()
  final String productId;
  final String brand;
  final String? imageUrl;
  final double count;
  final double netQty;
  final int cost;
  final String desc;

  Product({
    required this.productId,
    required this.brand,
    required this.imageUrl,
    required this.count,
    required this.netQty,
    required this.cost,
    required this.desc,
  });
}
