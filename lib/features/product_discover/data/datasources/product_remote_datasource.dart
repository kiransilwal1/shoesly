import 'package:shoesly/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final SupabaseClient db;

  ProductRemoteDataSourceImpl({required this.db});
  @override
  Future<List<ProductModel>> getProduct() async {
    try {
      final result = await db.rpc('get_all_product');
      List<ProductModel> productModels = [];
      for (var items in result) {
        productModels.add(ProductModel.fromMap(items));
      }
      return productModels;
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
