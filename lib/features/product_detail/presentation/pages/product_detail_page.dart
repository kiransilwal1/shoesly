// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/entities/product_variation.dart';
import 'package:shoesly/features/product_detail/presentation/widgets/product_detail_thumbnail.dart';
import 'package:shoesly/features/product_detail/presentation/widgets/shimmer_product_detail.dart';
import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/alert.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../product_discover/presentation/widgets/product_rating.dart';
import '../widgets/add_to_cart_bottom_sheet.dart';
import '../../../product_review/presentation/bloc/product_review_bloc.dart';
import '../../../product_review/presentation/pages/product_review.dart';
import '../../domain/entities/product_review.dart';
import '../bloc/product_detail_bloc.dart';
import '../widgets/product_detail_app_bar.dart';
import '../widgets/review_section.dart';
import '../widgets/see_reviews_button.dart';
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
                  BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                      if (state is ProductDetailSuccess) {
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
      appBar: const PreferredSize(
        preferredSize: const Size(0, 80),
        child: AppBarProductDetailPage(),
      ),
      body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state is ProudctDetailFailure) {
            showErrorPopup(context, state.errorMessage, 'BACK');
          }
        },
        builder: (context, state) {
          if (state is ProductDetailSuccess) {
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
                      //Thumbnail to display swipable product variant.
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
                      SizeOptionsView(
                          sizes: sizes.toSet().toList(),
                          onSizeSelected: (double value) {}),
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
                      ReviewSection(reviewCounts: reviewCounts),
                      SeeReviewsButton(
                          rating: rating,
                          size: size,
                          onTap: () {
                            context.read<ProductReviewBloc>().add(
                                  FilterReviewEvent(
                                      globalReviews: state
                                          .productDetailEntity.productReveiws,
                                      averageRating: rating,
                                      reviews: state
                                          .productDetailEntity.productReveiws,
                                      filterValue: 0),
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductReviewPage()),
                            );
                          }),
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
        return AddToCartBottomSheet(shoe: shoe);
      },
      barrierColor: AppTheme.neutral500.withOpacity(0.3),
    );
  }
}
