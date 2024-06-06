import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class EmptyReviewPage extends StatelessWidget {
  const EmptyReviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/404.gif',
              height: size.width * 0.4,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'No Ratings!',
              style: AppTheme.headline600,
            ),
          ],
        ),
      ),
    );
  }
}
