import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';
import '../../../../core/common/widgets/shimmers/shimmer_container_hard.dart';
import '../bloc/product_review_bloc.dart';

class SatrFilters extends StatelessWidget {
  const SatrFilters({
    super.key,
    required this.filterText,
  });

  final List<int> filterText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int stars in filterText)
            BlocBuilder<ProductReviewBloc, ProductReviewState>(
              builder: (context, state) {
                if (state is FilterReviewSuccess) {
                  return MinimalButton(
                    isDisabled: stars != state.filterValue,
                    style: LabelButtonStyle(
                        text: stars != 0 ? '$stars Star' : 'All'),
                    onPressed: () {
                      context.read<ProductReviewBloc>().add(
                            FilterReviewEvent(
                              globalReviews: state.globalReviews,
                              reviews: state.reviews,
                              averageRating: state.averageRating,
                              filterValue: stars,
                            ),
                          );
                    },
                  );
                } else {
                  return const ShimmerContainerHardEdge(
                      height: 20, width: double.infinity);
                }
              },
            ),
        ],
      ),
    );
  }
}
