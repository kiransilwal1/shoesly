import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/entities/product_variation.dart';

import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/standard_app_bar.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../bloc/paywall_bloc.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key});

  final List<String> sortButtonText = [
    'Most Recent',
    'Lowest Price',
    'Highest Price'
  ];

  final List<String> genderText = ['Man', 'Woman', 'Unisex'];
  final List<String> colorText = ['Black', 'White', 'Red'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductPaymentBloc, ProductPaymentState>(
      listener: (context, state) {
        if (state is ProductPaymentFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          double grandTotal =
              state.cart.products.fold(0, (sum, item) => sum + item.price);
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
                            'GRAND TOTAL',
                            style: AppTheme.body100
                                .copyWith(color: AppTheme.neutral300),
                          ),
                          Text(
                            '\$${(grandTotal + Constants.kDeliveryCharge).toStringAsFixed(2)}',
                            style: AppTheme.headline600
                                .copyWith(color: AppTheme.neutral500),
                          ),
                        ],
                      ),
                      PrimaryButton(
                        isDisabled: false,
                        style: const LabelButtonStyle(text: 'PAYMENT'),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => DiscoverPage()),
                          // );
                        },
                      )
                    ],
                  ),
                ),
              ),
              appBar: PreferredSize(
                preferredSize: Size(0, 80),
                child: StandardAppBar(
                  title: 'Order Summary',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Information',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const ExpandableWidget(
                        title: 'Payment Method',
                        description: 'Credit Card',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      const ExpandableWidget(
                        title: 'Location',
                        description: 'Semarang, Indonesia',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Order Detail',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        children: <Widget>[
                          for (ProductVariation items
                              in state.cart.products.toSet().toList())
                            OrderDetailWidget(
                              itemTitle: items.title,
                              itemDescription:
                                  '${items.brandname} . ${items.colorName} . ${items.size}}',
                              itemQuantity: state.cart.products
                                  .where((element) => element.id == items.id)
                                  .length,
                              itemPrice:
                                  '\$${(state.cart.products.where((element) => element.id == items.id).length * items.price).toStringAsFixed(2)}',
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Payment Detail',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      PaymentDetailRowWidget(
                        title: 'Sub Total',
                        amount: '\$${grandTotal.toStringAsFixed(2)}',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      PaymentDetailRowWidget(
                        title: 'Shipping',
                        amount:
                            '\$${Constants.kDeliveryCharge.toStringAsFixed(2)}',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      PaymentDetailRowWidget(
                        title: 'Total Order',
                        amount:
                            '\$${(grandTotal + Constants.kDeliveryCharge).toStringAsFixed(2)}',
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ));
        } else {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(0, 80),
              child: StandardAppBar(
                  title: 'Order Summary',
                  onBack: () {
                    Navigator.pop(context);
                  }),
            ),
            body: const Center(
              child: Text('Loading...'),
            ),
          );
        }
      },
    );
  }
}

class PaymentDetailRowWidget extends StatelessWidget {
  const PaymentDetailRowWidget({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.body100.copyWith(color: Colors.grey[600]),
            ),
            Text(
              amount,
              style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
            )
          ],
        ),
      ],
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    super.key,
    required this.itemTitle,
    required this.itemDescription,
    required this.itemQuantity,
    required this.itemPrice,
  });
  final String itemTitle;
  final String itemDescription;
  final int itemQuantity;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemTitle,
                style:
                    AppTheme.headline400.copyWith(color: AppTheme.neutral500),
              ),
              Text(
                '$itemDescription . Qty $itemQuantity',
                style: AppTheme.body100.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            itemPrice,
            style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
          )
        ],
      ),
    );
  }
}

class ExpandableWidget extends StatelessWidget {
  const ExpandableWidget({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO: expand when pressed on arrow-right
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.headline300,
              ),
              Text(
                description,
                style: AppTheme.body200,
              ),
            ],
          ),
          SvgPicture.asset('assets/icons/arrow-right.svg',
              colorFilter:
                  const ColorFilter.mode(AppTheme.neutral300, BlendMode.srcIn)),
        ],
      ),
    );
  }
}
