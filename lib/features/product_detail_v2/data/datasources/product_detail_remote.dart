import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/product_detail_v2/data/models/product_detail_model.dart';
import 'package:shoesly/features/product_detail_v2/data/models/product_review_mode.dart';
import 'package:shoesly/features/product_detail_v2/data/models/product_variation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

abstract interface class ProductDetailRemote {
  Future<ProductDetailModel> loadProductDetail({required String id});
}

class ProudctDetailRemote implements ProductDetailRemote {
  final SupabaseClient db;

  ProudctDetailRemote({required this.db});
  @override
  Future<ProductDetailModel> loadProductDetail({required String id}) async {
    try {
      final product = await db.from('product').select('*').eq('id', id);
      final ProductModel productModel = ProductModel.fromMap(product.first);

      final variations =
          await db.from('product_variations').select('*').eq('product_id', id);
      final List<ProductVariationModel> productVariation =
          variations.map((e) => ProductVariationModel.fromMap(e)).toList();
      final reviews = await db
          .from('product_reviews')
          .select('*')
          .eq('product_id', id)
          .select('*,product_user!inner(*)');
      List<ProductReviewModel> productReviewModel = [];
      for (final review in reviews) {
        productReviewModel.add(ProductReviewModel.fromMap(review));
      }

      // final List<ProductReviewModel> productReviews =
      //     reviews.map((e) => ProductReviewModel.fromMap(e)).toList();
      return ProductDetailModel(
          product: productModel,
          productVariations: productVariation,
          productReveiws: productReviewModel);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
