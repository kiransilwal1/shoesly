import 'package:flutter/foundation.dart';
import 'package:shoesly/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/shoe_model.dart';

abstract interface class ShoeRemoteDataSource {
  Future<List<ShoeModel>> getAllShoes();
  Future<List<ShoeModel>> filterShoes({
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
  Future<List<ShoeModel>> getAllShoes() async {
    try {
      final shoes = await db.from('shoe').select('*').select('''
    *,
    brand:brand_id ( * ),
    review: review( * )
  ''');
      return shoes.map((shoe) => ShoeModel.fromJson(shoe)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ShoeModel>> filterShoes({
    String? shoeBrand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    String? color,
  }) async {
    try {
      //TODO: Qeury all data and then use filter on the object and return the appropriate object.
      if (shoeBrand == 'All') {
        final shoes = await db.from('shoe').select('*').select('''
    *,
    brand:brand_id ( * ),
    review: review( * )
  ''');
        return shoes.map((shoe) => ShoeModel.fromJson(shoe)).toList();
      } else {
        final shoes = await db
            .from('shoe')
            .select('*,brand!inner(*)')
            .eq('brand.id', shoeBrand!)
            .select()
            .select('*,review!inner(*)');

        return shoes.map((shoe) => ShoeModel.fromJson(shoe)).toList();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
