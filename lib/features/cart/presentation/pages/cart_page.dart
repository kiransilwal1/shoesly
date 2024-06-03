import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/features/paywall/presentation/pages/order_summary.dart';
import 'package:shoesly/features/product_detail_v2/domain/entities/product_variation.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../../../product_cart/presentation/bloc/product_cart_bloc.dart';
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
    return BlocConsumer<ProductCartBloc, ProductCartState>(
      listener: (context, state) {
        if (state is ProductCartFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is ProductCartSuccess) {
          if (state.cart.products.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Please add some items to cart first.')),
            );
          }
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
                          grandTotal.toStringAsFixed(2),
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
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 100),
              child: CartListView(itemList: state.cart.products),
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
  final List<ProductVariation> itemList;

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  late List<ProductVariation> uniqueItems;

  @override
  void initState() {
    super.initState();
    uniqueItems = widget.itemList.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(uniqueItems.length.toString());
    return ListView.builder(
      itemCount: uniqueItems.length,
      itemExtent: 120,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(
              'item_${uniqueItems[index].id}'), // Use a unique identifier from ProductVariation
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
              uniqueItems.removeAt(index);
            });
            // context.read<CartBloc>().add(SwipeToDeleteEvent(
            //     shoe: uniqueItems[index].variations, quantity: 1));
          },
          child: CartProductWidget(
            item: uniqueItems[index],
            itemList: widget.itemList, // Use the original itemList for counting
          ),
        );
      },
    );
  }
}

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.item,
    required this.itemList,
  });
  final List<ProductVariation> itemList;
  final ProductVariation item;

  @override
  Widget build(BuildContext context) {
    int count = itemList.where((obj) => obj == item).length;
    debugPrint(count.toString());
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
            child: CachedNetworkImage(imageUrl: item.image),
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
                      item.title,
                      softWrap: true,
                      style: AppTheme.headline400
                          .copyWith(color: AppTheme.neutral500),
                    ),
                  ),
                  Text(
                    '${item.brandname} . ${item.colorName} . ${item.size}',
                    style: AppTheme.body100.copyWith(color: Colors.grey[600]),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.price.toStringAsFixed(2),
                          style: AppTheme.headline600
                              .copyWith(color: AppTheme.neutral500),
                        ),
                        CartAdd(
                          product: item,
                          productCount: count,
                        ),
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
  CartAdd({super.key, required this.product, required this.productCount});

  @override
  _CartAddState createState() => _CartAddState();
  final ProductVariation product;
  int productCount;
}

class _CartAddState extends State<CartAdd> {
  void _incrementCounter() {
    context.read<ProductCartBloc>().add(AddToCart(product: widget.product));
    setState(() {
      widget.productCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.productCount > 0) {
        widget.productCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.productCount);
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
            color: widget.productCount > 0 ? AppTheme.neutral500 : Colors.grey,
          ),
        ),
        Text(
          '${widget.productCount}',
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
