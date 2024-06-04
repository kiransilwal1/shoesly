// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Variation {
  final String id;
  final String colorcode;
  final String colorname;
  final String image;
  final double size;
  final DateTime createdAt;
  final String productId;
  Variation({
    required this.id,
    required this.colorcode,
    required this.colorname,
    required this.image,
    required this.size,
    required this.createdAt,
    required this.productId,
  });
}
