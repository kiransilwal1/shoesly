class Brand {
  int count;
  String id;
  String image;
  String name;

  Brand({
    required this.count,
    required this.id,
    required this.image,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      count: json['count'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'id': id,
      'image': image,
      'name': name,
    };
  }
}

class ColorSize {
  String colorCode;
  String colorName;
  String id;
  String image;
  double saleprice;
  double size;
  DateTime createdAt;
  String description;
  double price;

  ColorSize({
    required this.colorCode,
    required this.colorName,
    required this.id,
    required this.image,
    required this.saleprice,
    required this.size,
    required this.createdAt,
    required this.description,
    required this.price,
  });

  factory ColorSize.fromJson(Map<String, dynamic> json) {
    print(json);
    return ColorSize(
      colorCode: json['colorCode'],
      colorName: json['colorName'],
      id: json['id'],
      image: json['image'],
      saleprice: (json['saleprice']).toDouble(),
      size: json['size'].toDouble(),
      createdAt: json['created_at'].toDate(),
      description: json['description'],
      price: json['saleprice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colorCode': colorCode,
      'colorName': colorName,
      'id': id,
      'image': image,
      'saleprice': saleprice,
      'size': size,
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'price': price,
    };
  }
}

// TODO: use static image for user
class Review {
  String comment;
  String name;
  int rating;
  DateTime reviewedAt;

  Review({
    required this.comment,
    required this.name,
    required this.rating,
    required this.reviewedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      name: json['name'],
      rating: json['rating'],
      reviewedAt: json['reviewed_at'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'name': name,
      'rating': rating,
      'reviewed_at': reviewedAt.toIso8601String(),
    };
  }
}

class Shoe {
  DateTime createdAt;
  String description;
  double price;
  double salePrice;
  String thumbnailImageUrl;
  String id;
  String brandName;
  int reviewCount;
  double averageRating;
  String brandImageUrl;

  Shoe({
    required this.createdAt,
    required this.description,
    required this.price,
    required this.salePrice,
    required this.thumbnailImageUrl,
    required this.id,
    required this.brandName,
    required this.reviewCount,
    required this.averageRating,
    required this.brandImageUrl,
  });
}
