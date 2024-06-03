class ProductEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final double price;
  final String image;
  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.price,
    required this.image,
  });
}
