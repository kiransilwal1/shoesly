import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/alert.dart';
import '../../../paywall/presentation/pages/order_summary.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key});

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
        if (state is CartLoaded) {
          return StreamBuilder<Cart>(
            stream: state.cartItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cart = snapshot.data!;
                if (cart.items.isEmpty) {
                  return const Scaffold(
                    body: Center(child: Text('Cart is empty')),
                  );
                }
                double totalPrice = cart.items
                    .map((item) => item.price)
                    .reduce((sum, price) => sum + price);
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
                              ),
                              Text(
                                '\$$totalPrice',
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderSummary()),
                              );
                            },
                            child: const Text('CHECK OUT'),
                          )
                        ],
                      ),
                    ),
                  ),
                  appBar: AppBar(
                    toolbarHeight: 60,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: const Text(
                      'Cart',
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: const Padding(
                    padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
                    child: CartListView(),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
            },
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
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  List<String> _dummyData = List.generate(1, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

//TODO: The minimum width size supported is 351 but 370ish for the two columns grid display

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
                      'Jordan 1 Retro High Tie Dye',
                      softWrap: true,
                      style: AppTheme.headline400
                          .copyWith(color: AppTheme.neutral500),
                    ),
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
