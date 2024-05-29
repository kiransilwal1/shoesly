import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
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
                Image.asset('assets/icons/nike.png'),
                // TODO: Image provided has background
                Image.asset(
                  'assets/products/product.png',
                  height: 85,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          // Wrap with Expanded to avoid overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Define max text length to avoid overflow
              Text(
                'Jordan 1 Retro High Tie Dye',
                style: AppTheme.body100,
              ),
              const SizedBox(
                height: 12,
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
                    '4.5',
                    style: AppTheme.headline300.copyWith(fontSize: 11),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(1045 Reviews)',
                    style: AppTheme.body100.copyWith(
                      fontSize: 11,
                      color: AppTheme.neutral300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '\$235,00',
                style: AppTheme.headline300,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
