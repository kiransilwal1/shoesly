import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/features/product_filter/domain/usecases/filter_page_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/brand_model.dart';
import '../../../../core/models/product_model.dart';

abstract class ProductFilterRemoteDatasource {
  Future<List<BrandModel>> getBrands();
  Future<List<ProductModel>> filterProducts(FilterParams params);
}

class ProductFilterRemoteDatasourceImpl
    implements ProductFilterRemoteDatasource {
  final SupabaseClient db;

  ProductFilterRemoteDatasourceImpl({required this.db});
  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final result = await db.rpc('get_brand_with_count_v2');
      List<BrandModel> brandModels = [];
      for (var items in result) {
        brandModels.add(BrandModel.fromMap(items));
      }
      return brandModels;
    } on PostgrestException catch (e) {
      throw ServerException(e.details.toString());
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<List<ProductModel>> filterProducts(FilterParams params) async {
    try {
      //TODO: Shittiest way of doing things. Need to optimize
      bool isAscendng = params.sortBy == 'Highest Price' ? false : true;
      String columnName =
          params.sortBy == 'Highest Price' || params.sortBy == 'Lowest Price'
              ? 'price'
              : 'created_at';

      final result = await await db.rpc('get_shoes_by_filter_v3', params: {
        'shoebrand':
            params.shoeBrand != null ? params.shoeBrand!.toUpperCase() : 'All',
        'minprice': params.minPrice ?? 0,
        'maxprice': params.maxPrice ?? 1000000,
        'colorstring': params.color ?? 'All',
      }).order(columnName ?? 'price', ascending: isAscendng);
      List<ProductModel> productModels = [];
      for (var item in result) {
        productModels.add(ProductModel.fromMap(item));
      }
      return productModels;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
