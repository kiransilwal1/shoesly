import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class SeeReviewsButton extends StatelessWidget {
  const SeeReviewsButton({
    super.key,
    required this.rating,
    required this.size,
    required this.onTap,
  });

  final double rating;
  final Size size;
  final Null Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            width: size.width * 0.6,
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.neutral200, width: 2),
                borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Center(
                child: Text(
                  'SEE ALL REVIEWS',
                  style:
                      AppTheme.headline300.copyWith(color: AppTheme.neutral500),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
