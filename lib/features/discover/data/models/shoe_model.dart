import 'package:shoesly/features/discover/domain/entities/shoes.dart';

class ShoeModel extends Shoe {
  ShoeModel(
      {required super.createdAt,
      required super.description,
      required super.price,
      required super.salePrice,
      required super.thumbnailImageUrl,
      required super.id,
      required super.brandName,
      required super.reviewCount,
      required super.averageRating,
      required super.brandImageUrl});

  factory ShoeModel.fromJson(Map<String, dynamic> json) {
    int count = json['review'].length;
    double sum = 0;
    for (var items in json['review']) {
      sum = sum + items['rating'];
    }
    double avg = sum / count;
    return ShoeModel(
        createdAt: DateTime.parse(json['created_at']),
        description: json['description'],
        price: json['price'],
        salePrice: json['saleprice'].toDouble(),
        thumbnailImageUrl: json['thumbnail_image_url'],
        id: json['id'].toString(),
        brandName: json['brand']['id'],
        reviewCount: count,
        averageRating: avg,
        brandImageUrl: json['brand']['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'price': price,
      'saleprice': salePrice,
      'thumbnail_image_url': thumbnailImageUrl,
      'id': id,
      'brandName': brandName,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'brandImageUrl': brandImageUrl,
    };
  }
}
