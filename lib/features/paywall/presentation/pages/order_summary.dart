import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/features/discover/presentation/pages/discover_page.dart';

import '../../../../core/widgets/buttons/primary_buttons.dart';

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
                      'GRAND TOTAL',
                      style:
                          AppTheme.body100.copyWith(color: AppTheme.neutral300),
                    ),
                    Text(
                      '\$705.00',
                      style: AppTheme.headline600
                          .copyWith(color: AppTheme.neutral500),
                    ),
                  ],
                ),
                PrimaryButton(
                  isDisabled: false,
                  style: const LabelButtonStyle(text: 'PAYMENT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DiscoverPage()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 60,
          leading: const MinimalButton(
              isDisabled: false,
              style: IconOnlyStyle(iconImagePath: 'assets/icons/back.png')),
          title: Text(
            'Order Summary',
            style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                const OrderDetailWidget(
                  itemTitle: 'Jordan 1 Retro High Tie Dye',
                  itemDescription: 'Nike . Red Grey . 40',
                  itemQuantity: 1,
                  itemPrice: '\$235,00',
                ),
                const OrderDetailWidget(
                  itemTitle: 'Jordan 1 Retro High Tie Dye',
                  itemDescription: 'Nike . Red Grey . 40',
                  itemQuantity: 1,
                  itemPrice: '\$235,00',
                ),
                const OrderDetailWidget(
                  itemTitle: 'Jordan 1 Retro High Tie Dye',
                  itemDescription: 'Nike . Red Grey . 40',
                  itemQuantity: 1,
                  itemPrice: '\$235,00',
                ),
                const OrderDetailWidget(
                  itemTitle: 'Jordan 1 Retro High Tie Dye',
                  itemDescription: 'Nike . Red Grey . 40',
                  itemQuantity: 1,
                  itemPrice: '\$235,00',
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
                const PaymentDetailRowWidget(
                  title: 'Sub Total',
                  amount: '\$705.00',
                ),
                const SizedBox(
                  height: 16,
                ),
                const PaymentDetailRowWidget(
                  title: 'Shipping',
                  amount: '\$20,00',
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                const PaymentDetailRowWidget(
                  title: 'Total Order',
                  amount: '\$725.00',
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ));
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
          //TODO: exapnd when pressed on arrow-right
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
          SvgPicture.asset(
            'assets/icons/arrow-right.svg',
            color: AppTheme.neutral300,
          )
        ],
      ),
    );
  }
}
