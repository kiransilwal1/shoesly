import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/primary_buttons.dart';
import 'package:shoesly/core/widgets/buttons/secondary_buttons.dart';
import 'package:shoesly/features/cart/presentation/pages/cart_page.dart';
import 'package:shoesly/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/product-detail/domain/entities/shoe_details_entity.dart';
import 'package:shoesly/features/product_review/presentation/pages/product_review.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/reviews.dart';
import '../bloc/product_detail_bloc.dart';

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
                          '\$${state.shoeDetailsEntity.salePrice}',
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'ADD TO CART'),
                      onPressed: () {
                        _showBottomSheet(context);
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
                    ProductDetailContainer(
                      mainImageUrl: state.shoeDetailsEntity.imageUrl,
                      size: size,
                      shoes: state.shoeDetailsEntity.shoeVariations,
                    ),
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
                    Row(
                      children: [
                        Row(
                          children: [
                            for (int i = 0;
                                i < state.shoeDetailsEntity.averageRating;
                                i++)
                              SizedBox(
                                height: 12,
                                child: Image.asset('assets/icons/star.png'),
                              )
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          state.shoeDetailsEntity.averageRating
                              .toStringAsFixed(2),
                          style: AppTheme.headline300.copyWith(fontSize: 11),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(${state.shoeDetailsEntity.reviewCount} Reviews)',
                          style: AppTheme.body100.copyWith(
                            fontSize: 11,
                            color: AppTheme.neutral300,
                          ),
                        ),
                      ],
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
                    SingleChildScrollView(
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
                    ),
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
                          Reviews(
                            description: review.userDescription,
                            name: review.userName,
                            rating: review.userRating,
                            imageUrl: review.imageUrl,
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
                              print('Navigating to review');
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
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
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
                        const CustomTextFieldWithButtons(),
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
                                    '\$235.00',
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

class ProductDetailContainer extends StatelessWidget {
  const ProductDetailContainer({
    super.key,
    required this.size,
    required this.shoes,
    required this.mainImageUrl,
  });

  final List<ShoeVariations> shoes;
  final String mainImageUrl;

  final Size size;

  @override
  Widget build(BuildContext context) {
    List<String> colorString = shoes.map((e) => e.colorCode).toList();
    int variationCount = shoes.length;
    return Container(
      height: size.width * 0.8,
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
            CachedNetworkImage(imageUrl: mainImageUrl),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < variationCount; i++)
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: CircleAvatar(
                          maxRadius: 3,
                          backgroundColor: AppTheme.neutral500,
                        ),
                      ),
                  ],
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
                      children: [
                        for (String color in colorString)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
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
                          ),
                      ],
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
      hexColor = 'FF' + hexColor; // Add the alpha value if not provided
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

class CustomTextFieldWithButtons extends StatefulWidget {
  const CustomTextFieldWithButtons({Key? key}) : super(key: key);

  @override
  _CustomTextFieldWithButtonsState createState() =>
      _CustomTextFieldWithButtonsState();
}

class _CustomTextFieldWithButtonsState
    extends State<CustomTextFieldWithButtons> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController(text: '1');
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _incrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      _controller.text = (currentValue + 1).toString();
    });
  }

  void _decrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      if (currentValue > 1) {
        _controller.text = (currentValue - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: 'Enter number',
        suffixIcon: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MinimalButton(
                isDisabled: false,
                style: const IconOnlyStyle(
                  iconImagePath: 'assets/icons/minus-cirlce.png',
                ),
                onPressed: _decrementValue,
              ),
              MinimalButton(
                isDisabled: false,
                style: const IconOnlyStyle(
                    iconImagePath: 'assets/icons/add-circle.png'),
                onPressed: _incrementValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
