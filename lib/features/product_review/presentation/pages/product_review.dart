import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/core/common/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/common/widgets/buttons/minimal_buttons.dart';

import '../../../../core/common/widgets/alert.dart';
import '../bloc/product_review_bloc.dart';
import '../widgets/empty_review.dart';
import '../widgets/review_filter.dart';
import '../widgets/review_section.dart';

class ProductReviewPage extends StatelessWidget {
  ProductReviewPage({super.key});

  final List<int> filterText = [0, 5, 4, 3, 2, 1];
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductReviewBloc, ProductReviewState>(
      listener: (context, state) {
        if (state is FilterReviewFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is FilterReviewSuccess) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(0, 80),
              child: AppBar(
                scrolledUnderElevation: 0.0,
                toolbarHeight: 90,
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/icons/star.png',
                            height: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            state.averageRating.toStringAsFixed(2),
                            style: AppTheme.headline300.copyWith(
                                color: AppTheme.neutral500, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  )
                ],
                leading: MinimalButton(
                  isDisabled: false,
                  style: const IconOnlyStyle(
                      iconImagePath: 'assets/icons/back.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  textAlign: TextAlign.center,
                  'Review (${state.reviews.length})',
                  style:
                      AppTheme.headline400.copyWith(color: AppTheme.neutral500),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter buttons
                // TODO: Display something when there is no review for some filters.
                SatrFilters(filterText: filterText),
                const SizedBox(
                  height: 20,
                ),
                state.reviews.isNotEmpty
                    ? UserReviews(reviews: state.reviews)
                    : const EmptyReviewPage(),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
