import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_filter_event.dart';
part 'product_filter_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductFilterBloc() : super(ProductFilterInitial()) {
    on<ProductFilterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
