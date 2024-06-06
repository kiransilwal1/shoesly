import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/core/common/widgets/standard_app_bar.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/common/widgets/alert.dart';
import '../bloc/paywall_bloc.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/expandable_row.dart';
import '../widgets/payment_successful.dart';
import '../widgets/product_listing.dart';
import '../widgets/total_order.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductPaymentBloc, ProductPaymentState>(
      listener: (context, state) {
        if (state is ProductPaymentFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
        if (state is ProductPaymentSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PaymentSuccessfullDialog();
            },
          );
        }
      },
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          double grandTotal =
              state.cart.products.fold(0, (sum, item) => sum + item.price);
          return Scaffold(
              bottomSheet: OrderSummaryBottomSheet(
                grandTotal: grandTotal,
                cart: state.cart,
              ),
              appBar: PreferredSize(
                preferredSize: const Size(0, 80),
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
                      DisplayProducts(cart: state.cart),
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
                      TotalOrderWidget(
                        title: 'Sub Total',
                        amount: '\$${grandTotal.toStringAsFixed(2)}',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TotalOrderWidget(
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
                      TotalOrderWidget(
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
