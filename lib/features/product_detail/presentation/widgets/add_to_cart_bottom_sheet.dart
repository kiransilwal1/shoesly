import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/features/product_detail/presentation/widgets/text_field_plus_minus.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../../core/common/widgets/buttons/secondary_buttons.dart';
import '../../../../core/entities/product_variation.dart';
import '../../../product_cart/presentation/bloc/product_cart_bloc.dart';
import '../../../product_cart/presentation/pages/cart_page.dart';
import '../../../product_discover/presentation/pages/product_discover_page.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final ProductVariation shoe;

  const AddToCartBottomSheet({Key? key, required this.shoe}) : super(key: key);

  @override
  _AddToCartBottomSheetState createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
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
                    TextFieldWithPlusMinus(
                      onChanged: (changedValue) {
                        setState(() {
                          value = changedValue;
                        });
                      },
                    ),
                    Container(
                      height: 90,
                      color: Colors.white,
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
                                (widget.shoe.price * value).toStringAsFixed(2),
                                style: AppTheme.headline600
                                    .copyWith(color: AppTheme.neutral500),
                              ),
                            ],
                          ),
                          PrimaryButton(
                            isDisabled: false,
                            style: const LabelButtonStyle(text: 'ADD TO CART'),
                            onPressed: () {
                              context.read<ProductCartBloc>().add(BulkAddEvent(
                                  product: widget.shoe, quantity: value));
                              _showBottomSheetWithCart(
                                  quantity: value,
                                  context); // Close the bottom sheet
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
  }

  void _showBottomSheetWithCart(BuildContext context, {required int quantity}) {
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
                      '$quantity ${quantity == 1 ? 'Item' : 'Items'} Total',
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
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const ProductDiscoverPage(),
                            transitionDuration: Duration(milliseconds: 100),
                            transitionsBuilder: (_, anim, __, child) =>
                                FadeTransition(opacity: anim, child: child),
                          ),
                        );
                      },
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'TO CART'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
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
