part of 'product_review_bloc.dart';

sealed class ProductReviewEvent {}

final class FilterReviewEvent extends ProductReviewEvent {
  final List<ProductReview> reviews;
  final List<ProductReview> globalReviews;
  final double averageRating;
  final int filterValue;

  FilterReviewEvent(
      {required this.reviews,
      required this.globalReviews,
      required this.averageRating,
      required this.filterValue});
}
