import '../../../product_detail_v2/data/models/product_variation_model.dart';
import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({required List<ProductVariationModel> products})
      : super(products: products);

  CartModel copyWith({
    List<ProductVariationModel>? products,
  }) {
    return CartModel(
      products: products ?? this.products as List<ProductVariationModel>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      products: List<ProductVariationModel>.from(
        json['products']
            .map((product) => ProductVariationModel.fromJson(product)),
      ),
    );
  }
}
