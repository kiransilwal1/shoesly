import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.height,
      required this.width,
      required this.imageUrl,
      required this.iconUrl,
      required this.title,
      required this.averageRating,
      required this.ratingCounts,
      required this.price});
  final double height;
  final double width;
  final String imageUrl;
  final String iconUrl;
  final String title;
  final double averageRating;
  final int ratingCounts;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.neutral500.withOpacity(0.05),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.network(iconUrl),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: CachedNetworkImage(imageUrl: imageUrl),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.body100,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/star.png',
                    height: 12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    averageRating.toStringAsFixed(2),
                    style: AppTheme.headline300.copyWith(fontSize: 11),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    ratingCounts > 1
                        ? '$ratingCounts Reviews'
                        : '$ratingCounts Review',
                    style: AppTheme.body100.copyWith(
                      fontSize: 11,
                      color: AppTheme.neutral300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: AppTheme.headline300,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
