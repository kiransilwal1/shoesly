import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesly/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shoesly/core/entities/product_variation.dart';
import '../../../../core/theme/app_theme.dart';

class ProductDetailThumbnail extends StatefulWidget {
  const ProductDetailThumbnail({
    super.key,
    required this.size,
    required this.shoes,
    required this.mainImageUrl,
    required this.onSwiped,
  });

  final ProductDetailEntity shoes;
  final String mainImageUrl;
  final Size size;
  final Null Function(ProductVariation shoe) onSwiped;

  @override
  State<ProductDetailThumbnail> createState() => _ProductDetailThumbnailState();
}

class _ProductDetailThumbnailState extends State<ProductDetailThumbnail> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  List<T> getUniqueByProperty<T, K>(List<T> items, K Function(T) keySelector) {
    final Set<K> seenKeys = {};
    return items.where((item) {
      final key = keySelector(item);
      if (seenKeys.contains(key)) {
        return false;
      } else {
        seenKeys.add(key);
        return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> colorString =
        widget.shoes.productVariations.map((e) => e.colorCode).toSet().toList();
    int variationCount = widget.shoes.productVariations.length;
    int uniqueCount = getUniqueByProperty(
        widget.shoes.productVariations, (shoe) => shoe.colorCode).length;
    return Container(
      height: widget.size.width * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.neutral500.withOpacity(0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //TODO: Can have multiple products with the same color.
            SizedBox(
              height: widget.size.width * 0.5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  // context.read<ProductDetailBloc>().add(
                  //       ProductVariationSwipeEvent(
                  //         widget.shoes.copyWith(
                  //             selectedShoe: widget.shoes.shoeVariations[index]),
                  //       ),
                  //     );
                  setState(() {
                    _currentPage = index;
                    widget.onSwiped(widget.shoes.productVariations[index]);
                  });
                },
                itemCount: uniqueCount,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                      imageUrl: widget.shoes.productVariations[index].image);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: List.generate(uniqueCount, (index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: CircleAvatar(
                        maxRadius: 3,
                        backgroundColor: _currentPage == index
                            ? AppTheme.neutral500
                            : AppTheme.neutral300,
                      ),
                    );
                  }),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppTheme.neutral0,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(colorString.length, (index) {
                        String color = colorString[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppTheme.neutral200)),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: hexStringToColor(color),
                                ),
                              ),
                              if (_currentPage == index)
                                const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '').replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
