import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';

class ShoeDetailModel extends ShoeDetailsEntity {
  ShoeDetailModel(
      {required super.id,
      required super.title,
      required super.averageRating,
      required super.reviewCount,
      required super.salePrice,
      required super.imageUrl,
      required super.description,
      required super.reviews,
      required super.shoeVariations});
}
