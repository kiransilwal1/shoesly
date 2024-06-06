import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class TotalOrderWidget extends StatelessWidget {
  const TotalOrderWidget({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.body100.copyWith(color: Colors.grey[600]),
            ),
            Text(
              amount,
              style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
            )
          ],
        ),
      ],
    );
  }
}
