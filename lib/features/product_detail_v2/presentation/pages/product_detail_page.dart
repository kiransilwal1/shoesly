import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_variation.dart';

import 'package:shoesly/features/product_detail_v2/presentation/widgets/product_detail_thumbnail.dart';
import 'package:shoesly/features/product_detail_v2/presentation/widgets/shimmer_product_detail.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/minimal_buttons.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../../../../core/widgets/buttons/secondary_buttons.dart';
import '../../../../core/widgets/reviews.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../product-detail/presentation/widgets/product_rating.dart';
import '../../../product-detail/presentation/widgets/text_field_plus_minus.dart';
import '../../../product_review/presentation/bloc/product_review_bloc.dart';
import '../../../product_review/presentation/pages/product_review.dart';
import '../../domain/entities/product_review.dart';
import '../bloc/product_detail_v2_bloc.dart';
import '../widgets/size_option_view.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});
  ProductVariation? _selectedShoe;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Container(
        height: 90,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE',
                    style:
                        AppTheme.body100.copyWith(color: AppTheme.neutral300),
                  ),
                  BlocBuilder<ProductDetailV2Bloc, ProductDetailV2State>(
                    builder: (context, state) {
                      if (state is ProductDetailV2Success) {
                        return Text(
                          '\$${state.productDetailEntity.product.price.toStringAsFixed(2)}',
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
              PrimaryButton(
                isDisabled: false,
                style: const LabelButtonStyle(text: 'ADD TO CART'),
                onPressed: () {
                  if (_selectedShoe != null) {
                    _showBottomSheet(context: context, shoe: _selectedShoe!);
                  }
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/bag.svg',
                  color: Colors.black,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: BlocConsumer<ProductDetailV2Bloc, ProductDetailV2State>(
        listener: (context, state) {
          if (state is ProudctDetailV2Failure) {
            showErrorPopup(context, state.errorMessage, 'BACK');
          }
        },
        builder: (context, state) {
          if (state is ProductDetailV2Success) {
            _selectedShoe = state.productDetailEntity.productVariations.first;
            double rating = state.productDetailEntity.productReveiws
                    .map((m) => m.userRating)
                    .reduce((a, b) => a + b) /
                state.productDetailEntity.productReveiws.length;
            List<double> sizes = state.productDetailEntity.productVariations
                .map((e) => e.size)
                .toList();
            List<ProductReview> reviewCounts =
                state.productDetailEntity.productReveiws.length >= 3
                    ? state.productDetailEntity.productReveiws.sublist(0, 3)
                    : state.productDetailEntity.productReveiws;
            return Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailThumbnail(
                          size: size,
                          shoes: state.productDetailEntity,
                          mainImageUrl: state.productDetailEntity.product.image,
                          onSwiped: (ProductVariation shoe) {
                            _selectedShoe = shoe;
                            debugPrint('Selected shoe $shoe');
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        state.productDetailEntity.product.title,
                        style: AppTheme.headline600,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RatingView(
                        averageRating: rating,
                        reviewCount:
                            state.productDetailEntity.productReveiws.length,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Size',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizeOptionsView(sizes: sizes.toSet().toList()),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.productDetailEntity.product.description,
                        style: AppTheme.body200
                            .copyWith(color: AppTheme.neutral400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Review (${state.productDetailEntity.productReveiws.length.toString()})',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: [
                          for (var review in reviewCounts)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Reviews(
                                description: review.userDescription,
                                name: review.userName,
                                rating: review.userRating,
                                imageUrl: review.imageUrl,
                              ),
                            )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: SecondaryButton(
                              isDisabled: false,
                              style: const LabelButtonStyle(
                                  text: 'SEE ALL REVIEWS'),
                              onPressed: () {
                                context.read<ProductReviewBloc>().add(
                                      FilterReviewEvent(
                                          globalReviews: state
                                              .productDetailEntity
                                              .productReveiws,
                                          averageRating: rating,
                                          reviews: state.productDetailEntity
                                              .productReveiws,
                                          filterValue: 0),
                                    );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductReviewPage()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ]),
              ),
            );
          } else {
            return const ShimmerProductDetail();
          }
        },
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required ProductVariation shoe,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.neutral500.withOpacity(0.3),
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: AppTheme.neutral500.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add to cart',
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                        MinimalButton(
                          isDisabled: false,
                          style: const IconOnlyStyle(
                              iconImagePath: 'assets/icons/cross.png'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity',
                          style: AppTheme.headline300
                              .copyWith(color: AppTheme.neutral500),
                        ),
                        const TextFieldWithPlusMinus(),
                        Container(
                          height: 90,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PRICE',
                                    style: AppTheme.body100
                                        .copyWith(color: AppTheme.neutral300),
                                  ),
                                  Text(
                                    shoe.price.toStringAsFixed(2),
                                    style: AppTheme.headline600
                                        .copyWith(color: AppTheme.neutral500),
                                  ),
                                ],
                              ),
                              PrimaryButton(
                                isDisabled: false,
                                style:
                                    const LabelButtonStyle(text: 'ADD TO CART'),
                                onPressed: () {
                                  // context.read<CartBloc>().add(
                                  //     AddToCartEvent(shoe: shoe, quantity: 1));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: AppTheme.neutral500.withOpacity(0.3),
    );
  }

  void _showBottomSheetWithCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.neutral500.withOpacity(0.3),
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/tick-circle.svg',
                  height: 100,
                ),
                Column(
                  children: [
                    Text(
                      'Added to cart',
                      style: AppTheme.headline700,
                    ),
                    Text(
                      '1 Item Total',
                      style:
                          AppTheme.body200.copyWith(color: AppTheme.neutral400),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SecondaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'BACK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'TO CART'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      barrierColor: AppTheme.neutral500.withOpacity(0.3),
    );
  }
}
