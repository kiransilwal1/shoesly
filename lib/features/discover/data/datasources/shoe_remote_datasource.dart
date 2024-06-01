import 'package:flutter/material.dart';
import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/discover/data/models/discover_mode.dart';
import 'package:shoesly/features/discover/data/models/filter_model.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/brand_model.dart';
import '../models/color_model.dart';
import '../models/shoe_model.dart';

abstract class ShoeRemoteDataSource {
  Future<DiscoverModel> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  });

  getFilterParams() {}
}

class ShoeRemoteDataSourceImpl implements ShoeRemoteDataSource {
  final SupabaseClient db;

  ShoeRemoteDataSourceImpl({required this.db});

  @override
  Future<DiscoverModel> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  }) async {
    try {
      debugPrint(shoeBrand);
      final shoes = await db.rpc('get_shoes_by_filter', params: {
        'shoebrand': shoeBrand,
        'minprice': minPrice ?? 0,
        'maxprice': maxPrice ?? 1000000
      });
      //TODO: debug serialization issue
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
      DiscoverModel discover = DiscoverModel(
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

  @override
  Future<FilterModel> getFilterParams() async {
    try {
      final brands = await db.rpc('get_brand_with_count');
      List<BrandModel> brandModels = [];
      for (var brand in brands) {
        brandModels.add(BrandModel(
            brandName: brand['brand_id'],
            image: brand['brand_image_url'],
            id: brand['brand_id'],
            count: brand['item_count']));
      }
      final colors = await db.rpc('get_color_profiles');
      List<ColorModel> colorModels = [];
      for (var color in colors) {
        colorModels.add(
          ColorModel(
            colorCode: color['color_code'],
            name: color['color_name'],
          ),
        );
      }

      final price_range = await db.rpc('get_min_max_price');
      double minPrice = price_range[0]['min_price'].toDouble();
      double maxPrice = price_range[0]['max_price'].toDouble();

      final FilterModel filterModel = FilterModel(
          brands: brandModels,
          minPrice: minPrice,
          maxPrice: maxPrice,
          colorCodes: colorModels);
      return filterModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
