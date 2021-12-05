import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

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
