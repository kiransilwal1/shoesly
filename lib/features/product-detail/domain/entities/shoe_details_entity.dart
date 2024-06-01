// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShoeDetailsEntity {
  final int id;
  final String title;
  final double averageRating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final double salePrice;
  final List<Review> reviews;
  final List<ShoeVariations> shoeVariations;

  ShoeDetailsEntity(
      {required this.id,
      required this.title,
      required this.averageRating,
      required this.salePrice,
      required this.imageUrl,
      required this.reviewCount,
      required this.description,
      required this.reviews,
      required this.shoeVariations});
}

class ShoeVariations {
  final int id;
  final String colorCode;
  final double size;
  final String imageUrl;
  ShoeVariations({
    required this.id,
    required this.colorCode,
    required this.size,
    required this.imageUrl,
  });
}

class Review {
  final int id;
  final String imageUrl;
  final String userName;
  final int userRating;
  final String userDescription;
  Review({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.userRating,
    required this.userDescription,
  });
}
