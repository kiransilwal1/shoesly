class ProductReview {
  final String id;
  final String imageUrl;
  final String userName;
  final int userRating;
  final String userDescription;
  final DateTime createdAt;
  ProductReview({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.userRating,
    required this.userDescription,
    required this.createdAt,
  });
}
