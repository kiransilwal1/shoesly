import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_review_event.dart';
part 'product_review_state.dart';

class ProductReviewBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  ProductReviewBloc() : super(ProductReviewInitial()) {
    on<ProductReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
