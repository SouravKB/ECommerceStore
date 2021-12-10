class Product {
  final String productId;
  final String name;
  final String? imageUrl;
  final String shortDesc;
  final String category;
  final int price;
  final String desc;

  Product({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.shortDesc,
    required this.category,
    required this.price,
    required this.desc,
  });
}
