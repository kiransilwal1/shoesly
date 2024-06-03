import 'package:shoesly/features/product-detail/domain/entities/product_details_enitity.dart';

import '../../../../core/models/product_model.dart';
import 'product_variation_model.dart';

class ProductDetailModel extends ProductDetailWithVariations {
  ProductDetailModel(
      {required super.products, required super.productVariations});

  ProductDetailWithVariations copyWith({
    ProductModel? products,
    List<ProductVariationModel>? productVariations,
  }) {
    return ProductDetailWithVariations(
      products: products ?? this.products,
      productVariations: productVariations ?? this.productVariations,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'products': products.toMap(),
  //     'productVariations': productVariations.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory ProductDetailWithVariations.fromMap(Map<String, dynamic> map) {
  //   return ProductDetailWithVariations(
  //     products: Product.fromMap(map['products'] as Map<String,dynamic>),
  //     productVariations: List<ProductVariations>.from((map['productVariations'] as List<int>).map<ProductVariations>((x) => ProductVariations.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProductDetailWithVariations.fromJson(String source) => ProductDetailWithVariations.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'ProductDetailWithVariations(products: $products, productVariations: $productVariations)';

  // @override
  // bool operator ==(covariant ProductDetailWithVariations other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.products == products &&
  //     listEquals(other.productVariations, productVariations);
  // }

  // @override
  // int get hashCode => products.hashCode ^ productVariations.hashCode;
}
