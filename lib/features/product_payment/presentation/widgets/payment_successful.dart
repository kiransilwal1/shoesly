import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/product_payment/presentation/bloc/paywall_bloc.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';
import '../../../product_discover/presentation/pages/product_discover_page.dart';

class PaymentSuccessfullDialog extends StatelessWidget {
  const PaymentSuccessfullDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: Text(
        "Congratulations!!",
        style: AppTheme.headline600.copyWith(color: AppTheme.error600),
      ),
      actionsPadding: const EdgeInsets.all(16.0),
      contentTextStyle: AppTheme.body500.copyWith(color: AppTheme.neutral400),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: BlocBuilder<ProductPaymentBloc, ProductPaymentState>(
        builder: (context, state) {
          return state is ProductPaymentSuccess
              ? Text(
                  "Order successful please save your tracking id: ${state.trackingId}",
                )
              : const SizedBox();
        },
      ),
      actions: <Widget>[
        MinimalButton(
          isDisabled: false,
          style: const LabelButtonStyle(text: 'GO BACK'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ProductDiscoverPage(),
                transitionDuration: const Duration(milliseconds: 100),
                transitionsBuilder: (_, anim, __, child) =>
                    FadeTransition(opacity: anim, child: child),
              ),
            );
          },
        ),
      ],
    );
  }
}
