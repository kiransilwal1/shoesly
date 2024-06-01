import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.name,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
  final String name;
  final int rating;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppTheme.neutral100,
          foregroundImage: NetworkImage(imageUrl),
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
                    name,
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
                  for (int i = 0; i < rating; i++)
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
                description,
                style: AppTheme.body100.copyWith(color: AppTheme.neutral500),
              )
            ],
          ),
        ),
      ],
    );
  }
}
