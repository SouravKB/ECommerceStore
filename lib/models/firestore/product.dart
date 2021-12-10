import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

part 'product.g.dart';

@CfsModel()
class Product {
  @DocumentKey()
  final String productId;
  final String name;
  final String? imageUrl;
  final String shortDesc;
  final int price;
  final String desc;

  Product({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.shortDesc,
    required this.price,
    required this.desc,
  });
}
