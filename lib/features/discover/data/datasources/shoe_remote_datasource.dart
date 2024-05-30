import 'package:shoesly/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/shoe_model.dart';

abstract interface class ShoeRemoteDataSource {
  Future<List<ShoeModel>> getAllShoes();
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
}
