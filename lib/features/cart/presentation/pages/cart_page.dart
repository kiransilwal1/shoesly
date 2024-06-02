import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/features/cart/domain/entities/cart_items.dart';
import 'package:shoesly/features/paywall/presentation/pages/order_summary.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../bloc/cart_bloc.dart';

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
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is CartLoadedState) {
          if (state.cart.cartItems.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Please add some items to cart first.')),
            );
          }
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
                          state.cart.totalCartPrice.toStringAsFixed(2),
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'CHECK OUT'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderSummary()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              toolbarHeight: 60,
              leading: MinimalButton(
                isDisabled: false,
                style:
                    const IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Cart',
                style:
                    AppTheme.headline400.copyWith(color: AppTheme.neutral500),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
              child: CartListView(itemList: state.cart.cartItems),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
      },
    );
  }
}

class CartListView extends StatefulWidget {
  const CartListView({super.key, required this.itemList});
  final List<CartItems> itemList;

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  List<String> _dummyData = List.generate(1, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return ListView.builder(
      itemCount: widget.itemList.length,
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
            context.read<CartBloc>().add(SwipeToDeleteEvent(
                shoe: widget.itemList[index].variations, quantity: 1));
          },
          child: CartProductWidget(item: widget.itemList[index]),
        );
      },
    );
  }
}

//TODO: The minimum width size supported is 351 but 370ish for the two columns grid display

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.item,
  });

  final CartItems item;

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
            child: CachedNetworkImage(imageUrl: item.variations.imageUrl),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      item.variations.description
                          .split(" ")
                          .sublist(0, 3)
                          .join(" "),
                      softWrap: true,
                      style: AppTheme.headline400
                          .copyWith(color: AppTheme.neutral500),
                    ),
                  ),
                  Text(
                    '${item.variations.description.split(" ")[0]} . ${item.variations.colorName} . ${item.variations.size}',
                    style: AppTheme.body100.copyWith(color: Colors.grey[600]),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.variations.salePrice.toStringAsFixed(2),
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                        CartAdd(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
