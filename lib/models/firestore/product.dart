import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

part 'product.g.dart';

@CfsModel()
class Product {
  @DocumentKey()
  final String productId;
  final String brand;
  final String? imageUrl;
  final int count;
  final String netQty;
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
