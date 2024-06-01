import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/brands.dart';

class BrandSelectorView extends StatefulWidget {
  const BrandSelectorView({
    super.key,
    required this.brands,
    required this.onSelected,
  });
  final List<Brand> brands;
  final void Function(String value) onSelected;

  @override
  State<BrandSelectorView> createState() => _BrandSelectorViewState();
}

class _BrandSelectorViewState extends State<BrandSelectorView> {
  bool isSelected = true;
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Brand items in widget.brands)
          GestureDetector(
            onTap: () {
              widget.onSelected(items.brandName);
              setState(() {
                selectedId = items.brandName;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.neutral100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SvgPicture.network(
                              items.image,
                              color: AppTheme.neutral500,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              items.brandName,
                              style: AppTheme.headline300
                                  .copyWith(color: AppTheme.neutral500),
                            ),
                            Text(
                              '${items.count} items',
                              style: AppTheme.body10
                                  .copyWith(color: AppTheme.neutral300),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Currently not optimized. Selecting the brand will re-render this whole widget.
                  if (selectedId == items.brandName)
                    Positioned(
                      bottom: 50,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppTheme.neutral500,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
