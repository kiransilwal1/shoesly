import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/product-detail/data/models/product_detail_model.dart';
import 'package:shoesly/features/product-detail/data/models/shoe_variation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/review_model.dart';

abstract interface class ProductDetailDataSource {
  Future<ShoeDetailModel> getShoeDetail({required String id});
}

class ProductDetailDataSourceImpl implements ProductDetailDataSource {
  final SupabaseClient db;

  ProductDetailDataSourceImpl({required this.db});
  @override
  Future<ShoeDetailModel> getShoeDetail({required String id}) async {
    try {
      final reviews = await db
          .from('product_reviews')
          .select('*')
          .eq('product_id', id)
          .select('*,product_user!inner(*)')
          .order('rating', ascending: false);
      List<ReviewModel> reviewModels =
          reviews.map((e) => ReviewModel.fromMap(e)).toList();

      final variations = await db
          .from('product_variations')
          .select('*')
          .eq('product_id', id)
          .select('*,product!inner(*)');
      List<ShoeVariationModel> variationModel =
          variations.map((e) => ShoeVariationModel.fromMap(e)).toList();
      int reviewCount = reviews.length;
      double averageRating = calculateAverageRating(reviewModels);
      final shoe = await db
          .from('product')
          .select()
          .eq('id', id)
          .select('*,product_brand!inner(*)');
      ShoeDetailModel shoeDetail = ShoeDetailModel(
        id: id,
        imageUrl: shoe[0]['image'],
        brandName: shoe[0]['product_brand']['name'],
        title: shoe[0]['title'],
        averageRating: averageRating,
        reviewCount: reviewCount,
        salePrice: shoe[0]['sale_price'].toDouble(),
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
