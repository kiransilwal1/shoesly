// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Brand {
  final String brandName;
  final int count;
  final String image;
  final String id;

  Brand({
    required this.brandName,
    required this.count,
    required this.image,
    required this.id,
  });

  Brand copyWith({
    String? brandName,
    int? count,
    String? image,
    String? id,
  }) {
    return Brand(
      brandName: brandName ?? this.brandName,
      count: count ?? this.count,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandName': brandName,
      'count': count,
      'image': image,
      'id': id,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      brandName: map['brandName'] as String,
      count: map['count'] as int,
      image: map['image'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Brand(brandName: $brandName, count: $count, image: $image, id: $id)';
  }

  @override
  bool operator ==(covariant Brand other) {
    if (identical(this, other)) return true;

    return other.brandName == brandName &&
        other.count == count &&
        other.image == image &&
        other.id == id;
  }

  @override
  int get hashCode {
    return brandName.hashCode ^ count.hashCode ^ image.hashCode ^ id.hashCode;
  }
}
