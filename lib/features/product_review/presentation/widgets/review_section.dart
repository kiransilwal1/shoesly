import 'package:flutter/material.dart';

import '../../../../core/common/widgets/reviews.dart';
import '../../../product_detail/domain/entities/product_review.dart';

class UserReviews extends StatelessWidget {
  const UserReviews({
    super.key,
    required this.reviews,
  });

  final List<ProductReview> reviews;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              for (ProductReview userReview in reviews)
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
    );
  }
}
