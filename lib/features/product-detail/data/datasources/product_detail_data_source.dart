import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/product-detail/data/models/product_detail_model.dart';
import 'package:shoesly/features/product-detail/data/models/shoe_variation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/review_model.dart';

abstract interface class ProductDetailDataSource {
  Future<ShoeDetailModel> getShoeDetail({required int id});
}

class ProductDetailDataSourceImpl implements ProductDetailDataSource {
  final SupabaseClient db;

  ProductDetailDataSourceImpl({required this.db});
  @override
  Future<ShoeDetailModel> getShoeDetail({required int id}) async {
    try {
      final reviews = await db
          .from('review')
          .select('*, shoe_review!inner(*)')
          .eq('shoe_review.shoe_id', id)
          .order('rating', ascending: false);
      List<ReviewModel> reviewModels =
          reviews.map((e) => ReviewModel.fromMap(e)).toList();

      final variations = await db
          .from('shoevariation')
          .select('*, shoe_shoevariation!inner(*)')
          .eq('shoe_shoevariation.shoe_id', id)
          .order('id', ascending: true);
      List<ShoeVariationModel> variationModel =
          variations.map((e) => ShoeVariationModel.fromMap(e)).toList();
      int reviewCount = reviews.length;
      double averageRating = calculateAverageRating(reviewModels);
      final shoe = await db.from('shoe').select().eq('id', id);
      ShoeDetailModel shoeDetail = ShoeDetailModel(
        id: id,
        imageUrl: shoe[0]['thumbnail_image_url'],
        title: shoe[0]['description'].split(" ").length > 3
            ? shoe[0]['description'].split(" ").sublist(0, 3).join(' ')
            : shoe[0]['description'].split(" ").join(" "),
        averageRating: averageRating,
        reviewCount: reviewCount,
        salePrice: shoe[0]['saleprice'],
        description: shoe[0]['description'],
        reviews: reviewModels,
        shoeVariations: variationModel,
        selectedShoe: variationModel.first,
      );
      return shoeDetail;
    } catch (e) {
      throw (ServerException(e.toString()));
    }
  }

  double calculateAverageRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) {
      return 0;
    }

    int totalRating = 0;
    for (var review in reviews) {
      totalRating += review.userRating;
    }

    return totalRating / reviews.length;
  }
}
