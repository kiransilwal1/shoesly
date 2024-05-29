import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nolan Carder',
                    style: AppTheme.headline300,
                  ),
                  Text(
                    'Today',
                    style:
                        AppTheme.body100.copyWith(color: AppTheme.neutral300),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    SizedBox(
                      height: 12,
                      child: Image.asset('assets/icons/star.png'),
                    )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Perfect for keeping your feet dry and warm in damp conditions.',
                style: AppTheme.body100.copyWith(color: AppTheme.neutral500),
              )
            ],
          ),
        ),
      ],
    );
  }
}
