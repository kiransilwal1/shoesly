part of 'product_detail_v2_bloc.dart';

sealed class ProductDetailV2State {
  const ProductDetailV2State();
}

class ProductDetailV2Initial extends ProductDetailV2State {}

class ProductDetailV2Success extends ProductDetailV2State {
  final ProductDetailEntity productDetailEntity;

  ProductDetailV2Success({required this.productDetailEntity});
}

class ProudctDetailV2Failure extends ProductDetailV2State {
  final String errorMessage;

  ProudctDetailV2Failure({required this.errorMessage});
}
