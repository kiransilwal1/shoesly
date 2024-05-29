import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';

import 'package:shoesly/core/widgets/product_card.dart';

import '../../../../core/widgets/buttons/primary_buttons.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

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
                style: const LabelButtonStyle(text: 'CHECK OUT'),
                onPressed: () {},
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
          'Cart',
          style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
        child: CartListView(),
      ),
    );
  }
}

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  List<String> _dummyData = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _dummyData.length,
      itemExtent: 120,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key('item_$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.error500,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    'assets/icons/trash.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              _dummyData.removeAt(index);
            });
          },
          child: const CartProductWidget(),
        );
      },
    );
  }
}

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.neutral500.withOpacity(0.05),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/products/product.png',
              width: 80,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jordan 1 Retro High Tie Dye',
                  style:
                      AppTheme.headline400.copyWith(color: AppTheme.neutral500),
                ),
                Text(
                  'Nike . Red Grey . 40',
                  style: AppTheme.body100.copyWith(color: Colors.grey[600]),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$235.00',
                        style: AppTheme.headline600
                            .copyWith(color: AppTheme.neutral500),
                      ),
                      CartAdd(),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CartAdd extends StatefulWidget {
  @override
  _CartAddState createState() => _CartAddState();
}

class _CartAddState extends State<CartAdd> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _decrementCounter,
          padding: EdgeInsets.zero,
          icon: Image.asset(
            'assets/icons/minus-cirlce.png',
            width: 24,
            height: 24,
            color: _counter > 0 ? AppTheme.neutral500 : Colors.grey,
          ),
        ),
        Text(
          '$_counter',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          onPressed: _incrementCounter,
          padding: EdgeInsets.zero,
          icon: Image.asset(
            'assets/icons/add-circle.png',
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
        ),
      ],
    );
  }
}
