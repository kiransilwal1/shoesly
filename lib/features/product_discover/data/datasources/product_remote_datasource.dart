import 'dart:collection';

import 'package:shoesly/core/error/exceptions.dart';
import 'package:shoesly/core/models/brand_model.dart';
import 'package:shoesly/features/product_discover/data/models/product_data_model.dart';
import 'package:shoesly/features/product_discover/data/models/variation_model.dart';
import 'package:shoesly/features/product_discover/domain/entities/color_entites.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_entity.dart';
import 'package:shoesly/features/product_discover/domain/entities/filter_params.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductDataModel> getProduct();
  Future<FilterEntity> getFilterParams(ProductDataModel params);

  Future<ProductDataModel> filterProducts(FilterParams filters);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final SupabaseClient db;

  ProductRemoteDataSourceImpl({required this.db});
  @override
  Future<ProductDataModel> getProduct() async {
    try {
      final products = await db.rpc('get_all_product');
      List<ProductModel> productModels = [];
      for (var items in products) {
        productModels.add(ProductModel.fromMap(items));
      }

      final brands = await db.rpc('get_brand_with_count_v2');
      List<BrandModel> brandModels = [];
      for (var brand in brands) {
        brandModels.add(BrandModel.fromMap(brand));
      }
      final productVariations = await db.from('product_variations').select('*');
      List<VariationModel> variations = [];
      for (var variation in productVariations) {
        variations.add(VariationModel.fromMap(variation));
      }

      return ProductDataModel(
        products: productModels,
        brands: brandModels,
        productVariations: variations,
      );
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<FilterEntity> getFilterParams(ProductDataModel params) async {
    try {
      // final brandwithCount = await db.rpc('get_brand_with_count_v2');
      // List<Brand> brands = [];
      // for (var brand in brandwithCount) {
      //   brands.add(Brand(
      //       brandName: brand['brandname'],
      //       count: brand['item_count'],
      //       image: brand['brand_image_url'],
      //       id: brand['brand_id']));
      // }
      // final variations = await db.from('product_variations').select('*');
      // Set<ColorEntity> uniqueColors = {};
      // for (var item in variations) {
      //   uniqueColors.add(ColorEntity(
      //     name: item['colorname'],
      //     colorCode: item['colorcode'],
      //   ));
      // }
      // List<ColorEntity> uniqueColorsList = uniqueColors.toList();
      // final result = await db.rpc('get_max_price');
      // double maxPrice = double.parse(result.toString());
      // final minPriceQuery = await db.rpc('get_min_price');
      // double minPrice = double.parse(minPriceQuery.toString());
      // return FilterEntity(
      //   brands: brands,
      //   minPrice: minPrice,
      //   maxPrice: maxPrice,
      //   colorCodes: uniqueColorsList,
      // );
      double minPrice = params.products
          .map((product) => product.price)
          .reduce((value, element) => value < element ? value : element);
      double maxPrice = params.products
          .map((product) => product.price)
          .reduce((value, element) => value > element ? value : element);
      List<ColorEntity> colors = params.productVariations
          .map(
            (e) => ColorEntity(name: e.colorname, colorCode: e.colorcode),
          )
          .toList();
      return FilterEntity(
        brands: params.brands,
        minPrice: minPrice,
        maxPrice: maxPrice,
        colorCodes: HashSet<ColorEntity>.from(colors).toList(),
        stateData: ProductDataModel(
            brands: params.brands,
            productVariations: params.productVariations,
            products: params.products),
        globalData: ProductDataModel(
            brands: params.brands,
            productVariations: params.productVariations,
            products: params.products),
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<ProductDataModel> filterProducts(FilterParams filters) async {
    //  filters.globalData.
    try {
      List<ProductModel> products = filterProductsByParams(
          brandName: filters.shoeBrand,
          brands: filters.globalData.brands,
          products: filters.globalData.products,
          color: filters.color,
          maxPrice: filters.maxPrice,
          minPrice: filters.minPrice,
          gender: filters.gender,
          variations: filters.globalData.productVariations,
          sortBy: filters.sortBy);
      return ProductDataModel(
          products: products,
          brands: filters.globalData.brands,
          productVariations: filters.globalData.productVariations);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  List<ProductModel> filterProductsByParams({
    String? brandName,
    double? maxPrice,
    double? minPrice,
    String? gender,
    String? color,
    String? sortBy,
    required List<BrandModel> brands,
    required List<ProductModel> products,
    required List<VariationModel> variations,
  }) {
    try {
      List<ProductModel> filteredProducts = products;

      if (brandName != null && brandName != 'All') {
        BrandModel? brand = brands
            .firstWhere((brand) => brand.brandName == brandName.toUpperCase());

        String brandId = brand.id;

        filteredProducts = filteredProducts
            .where((product) => product.brandId == brandId)
            .toList();
      }

      if (minPrice != null) {
        filteredProducts = filteredProducts
            .where((product) => product.price >= minPrice)
            .toList();
      }

      if (maxPrice != null) {
        filteredProducts = filteredProducts
            .where((product) => product.price <= maxPrice)
            .toList();
      }

      if (color != null && color != 'All') {
        filteredProducts = filteredProducts.where((product) {
          return variations.any((variation) =>
              variation.productId == product.id &&
              variation.colorcode.toLowerCase() == color.toLowerCase());
        }).toList();
      }
      if (sortBy != null) {
        if (sortBy == "Lowest Price") {
          filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        } else if (sortBy == "Most Recent") {
          filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        } else if (sortBy == "Highest reviews") {
          filteredProducts
              .sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        }
      }
      return filteredProducts;
    } catch (e) {
      //TODO: For now returning emtpy list of objects.
      return [];
    }
  }
}
