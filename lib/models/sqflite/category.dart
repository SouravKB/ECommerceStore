import 'package:model_annotations/model_annotations.dart';

part 'category.g.dart';

@SqflModel()
class Category {
  final String categoryId;
  final String shopId;
  final String name;
  final String imageUrl;

  Category({
    required this.categoryId,
    required this.shopId,
    required this.name,
    required this.imageUrl,
  });
}
