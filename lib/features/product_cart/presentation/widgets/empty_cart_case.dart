import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';

class EmptyCartCase extends StatelessWidget {
  const EmptyCartCase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: MinimalButton(
            isDisabled: false,
            style: const IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Cart',
            style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/addtocart.gif',
                height: size.width * 0.4,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Please add items to cart!',
                style: AppTheme.headline600,
              ),
            ],
          ),
        ));
  }
}
