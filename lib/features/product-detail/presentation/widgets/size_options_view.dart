import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SizeOptionsView extends StatelessWidget {
  const SizeOptionsView({
    super.key,
    required this.sizes,
  });

  final List<int> sizes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int size in sizes)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.neutral200,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    size.toString(),
                    style: AppTheme.headline300
                        .copyWith(color: AppTheme.neutral400),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
