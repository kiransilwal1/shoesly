import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';
import 'shoes.dart';

class Discover {
  final FilterParams params;
  final List<Shoe> shoes;

  Discover({required this.params, required this.shoes});
}
