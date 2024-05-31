import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/discover/domain/entities/discover.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/shoe_model.dart';

abstract class ShoeRemoteDataSource {
  Future<Discover> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  });
}

class ShoeRemoteDataSourceImpl implements ShoeRemoteDataSource {
  final SupabaseClient db;

  ShoeRemoteDataSourceImpl({required this.db});

  @override
  Future<Discover> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  }) async {
    try {
      final shoes =
          await db.rpc('get_shoes_by_brand', params: {'shoebrand': shoeBrand});
      List<ShoeModel> shoeModels = [];
      for (var shoe in shoes) {
        shoeModels.add(ShoeModel(
            createdAt: DateTime.parse(shoe['created_at']),
            description: shoe['description'],
            price: shoe['price'].toDouble(),
            salePrice: shoe['saleprice'].toDouble(),
            thumbnailImageUrl: shoe['thumbnail_image_url'],
            id: shoe['id'].toString(),
            brandName: shoe['name'],
            reviewCount: shoe['review_count'],
            averageRating: shoe['average_rating'].toDouble(),
            brandImageUrl: shoe['image']));
      }
      Discover discover = Discover(
          params: FilterParams(
              color: color,
              gender: gender,
              sortBy: sortBy,
              maxPrice: maxPrice,
              minPrice: minPrice,
              shoeBrand: shoeBrand),
          shoes: shoeModels);
      if (shoeModels.isEmpty) {
        throw Exception('No shoes found for $shoeBrand');
      }
      return discover;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
