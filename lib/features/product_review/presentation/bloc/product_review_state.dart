part of 'product_review_bloc.dart';

sealed class ProductReviewState {
  const ProductReviewState();
}

class ProductReviewInitial extends ProductReviewState {}

final class FilterReviewLoading extends ProductReviewState {}

final class FilterReviewSuccess extends ProductReviewState {
  final List<Review> reviews;
  final List<Review> globalReviews;
  final double averageRating;
  final int filterValue;

  FilterReviewSuccess(
      {required this.globalReviews,
      required this.reviews,
      required this.averageRating,
      required this.filterValue});
}

final class FilterReviewFailure extends ProductReviewState {
  final String errorMessage;

  FilterReviewFailure({required this.errorMessage});
}
