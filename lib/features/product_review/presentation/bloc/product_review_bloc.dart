import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product_detail_v2/domain/entities/product_review.dart';

part 'product_review_event.dart';
part 'product_review_state.dart';

class ProductReviewBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  ProductReviewBloc() : super(ProductReviewInitial()) {
    on<ProductReviewEvent>((event, emit) {
      emit(ProductReviewInitial());
    });
    on<FilterReviewEvent>(_productFilter);
  }

  FutureOr<void> _productFilter(
      FilterReviewEvent event, Emitter<ProductReviewState> emit) {
    if (event.filterValue == 0) {
      emit(FilterReviewSuccess(
          globalReviews: event.globalReviews,
          reviews: event.globalReviews,
          averageRating: event.averageRating,
          filterValue: event.filterValue));
    } else {
      List<ProductReview> reviews = event.globalReviews
          .where((element) => element.userRating == event.filterValue)
          .toList();

      emit(FilterReviewSuccess(
          globalReviews: event.globalReviews,
          reviews: reviews,
          averageRating: event.averageRating,
          filterValue: event.filterValue));
    }
  }
}
