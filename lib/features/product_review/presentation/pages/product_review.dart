import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/reviews.dart';

import '../../../../core/widgets/alert.dart';
import '../../../product-detail/domain/entities/shoe_details_entity.dart';
import '../bloc/product_review_bloc.dart';

class ProductReviewPage extends StatelessWidget {
  ProductReviewPage({super.key});

  final List<int> filterText = [0, 1, 2, 3, 4, 5];
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
        print(state);
        if (state is FilterReviewSuccess) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
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
                          '${state.averageRating}',
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
                style: IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Review (${state.reviews.length})',
                style:
                    AppTheme.headline400.copyWith(color: AppTheme.neutral500),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter buttons
                // TODO: Display something when there is no review for some filters.
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int stars in filterText)
                        MinimalButton(
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
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (Review userReview in state.reviews)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Reviews(
                                  name: userReview.userName,
                                  rating: userReview.userRating,
                                  description: userReview.userDescription,
                                  imageUrl: userReview.imageUrl),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
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
