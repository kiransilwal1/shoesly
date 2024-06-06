import 'package:flutter/material.dart';

import '../../../../core/common/widgets/reviews.dart';
import '../../domain/entities/product_review.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.reviewCounts,
  });

  final List<ProductReview> reviewCounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var review in reviewCounts)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Reviews(
              description: review.userDescription,
              name: review.userName,
              rating: review.userRating,
              imageUrl: review.imageUrl,
            ),
          )
      ],
    );
  }
}
