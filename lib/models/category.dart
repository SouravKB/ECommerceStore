import 'package:model_builder/model_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category.g.dart';

@CfsModel()
class Category {
  @DocumentKey()
  final String categoryId;
  final String name;
  final String imageUrl;

  Category({
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });
}
