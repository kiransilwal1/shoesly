import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

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
