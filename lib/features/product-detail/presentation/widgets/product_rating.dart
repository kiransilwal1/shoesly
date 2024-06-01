import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/rating_star.dart';

class RatingView extends StatelessWidget {
  const RatingView({
    super.key,
    required this.averageRating,
    required this.reviewCount,
  });
  final double averageRating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 12,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: CurvedStar(
                    size: 12.0,
                    rating: averageRating,
                    index: index + 1,
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          averageRating.toStringAsFixed(2),
          style: AppTheme.headline300.copyWith(fontSize: 11),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '($reviewCount Reviews)',
          style: AppTheme.body100.copyWith(
            fontSize: 11,
            color: AppTheme.neutral300,
          ),
        ),
      ],
    );
  }
}
