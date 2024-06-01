import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/primary_buttons.dart';
import 'package:shoesly/core/widgets/buttons/secondary_buttons.dart';
import 'package:shoesly/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoesly/features/cart/presentation/pages/cart_page.dart';
import 'package:shoesly/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
import 'package:shoesly/features/product_review/presentation/pages/product_review.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/reviews.dart';
import '../bloc/product_detail_bloc.dart';
import '../widgets/product_detail_thumbnail.dart';
import '../widgets/product_rating.dart';
import '../widgets/size_options_view.dart';
import '../widgets/text_field_plus_minus.dart';
import 'product_detail_shimmer.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {
        if (state is ProductDetailFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is ProductDetailSuccess) {
          ShoeVariations _selectedShoe =
              state.shoeDetailsEntity.shoeVariations.first;
          final List<int> sizes = state.shoeDetailsEntity.shoeVariations
              .map((e) => e.size.toInt())
              .toList();
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
                          style: AppTheme.body100
                              .copyWith(color: AppTheme.neutral300),
                        ),
                        Text(
                          '\$${state.shoeDetailsEntity.selectedShoe.price.toStringAsFixed(2)}',
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'ADD TO CART'),
                      onPressed: () {
                        _showBottomSheet(context: context, shoe: _selectedShoe);
                      },
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 44, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MinimalButton(
                            isDisabled: false,
                            style: const IconOnlyStyle(
                                iconImagePath: 'assets/icons/back.png'),
                            onPressed: () {
                              context
                                  .read<DiscoverBloc>()
                                  .add(FilterShoes(shoeBrand: 'All'));
                              Navigator.pop(context);
                            },
                          ),
                          const MinimalButton(
                            isDisabled: false,
                            style: IconOnlyStyle(
                                iconImagePath: 'assets/icons/bag.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProductDetailThumbnail(
                        mainImageUrl: state.shoeDetailsEntity.imageUrl,
                        size: size,
                        shoes: state.shoeDetailsEntity,
                        onSwiped: (ShoeVariations shoe) {
                          _selectedShoe = shoe;
                          debugPrint('Selected shoe $shoe');
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      state.shoeDetailsEntity.title,
                      style: AppTheme.headline600,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    RatingView(
                      averageRating: state.shoeDetailsEntity.averageRating,
                      reviewCount: state.shoeDetailsEntity.reviewCount,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Size',
                      style: AppTheme.headline400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizeOptionsView(sizes: sizes),
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
                      state.shoeDetailsEntity.description,
                      style:
                          AppTheme.body200.copyWith(color: AppTheme.neutral400),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Review (${state.shoeDetailsEntity.reviewCount.toString()})',
                      style: AppTheme.headline400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        for (var review
                            in state.shoeDetailsEntity.reviews.sublist(0, 3))
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
                            style:
                                const LabelButtonStyle(text: 'SEE ALL REVIEWS'),
                            onPressed: () {
                              context.read<ProductReviewBloc>().add(
                                    FilterReviewEvent(
                                        globalReviews:
                                            state.shoeDetailsEntity.reviews,
                                        averageRating: state
                                            .shoeDetailsEntity.averageRating,
                                        reviews:
                                            state.shoeDetailsEntity.reviews,
                                        filterValue: 0),
                                  );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductReviewPage()),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: ProductDetailShimmer(),
          );
        }
      },
    );
  }

  void _showBottomSheet(
      {required BuildContext context, required ShoeVariations shoe, double}) {
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
                                    shoe.salePrice.toString(),
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
                                  context
                                      .read<CartBloc>()
                                      .add(AddToCartEvent(shoe));
                                  _showBottomSheetWithCart(context);
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
