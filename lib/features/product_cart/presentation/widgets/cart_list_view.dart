import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';
import '../../../../core/entities/product_variation.dart';
import '../bloc/product_cart_bloc.dart';
import 'cart_product_widget.dart';

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
    debugPrint(uniqueItems.length.toString());
    return ListView.builder(
      itemCount: uniqueItems.length,
      itemExtent: 120,
      itemBuilder: (context, index) {
        return Dismissible(
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text(
                    "Confirm",
                    style:
                        AppTheme.headline600.copyWith(color: AppTheme.error600),
                  ),
                  actionsPadding: EdgeInsets.all(16.0),
                  contentTextStyle:
                      AppTheme.body500.copyWith(color: AppTheme.neutral400),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  content:
                      const Text("Are you sure you wish to delete this item?"),
                  actions: <Widget>[
                    MinimalButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'DELETE'),
                      color: AppTheme.error600,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    MinimalButton(
                      isDisabled: false,
                      style: const LabelButtonStyle(text: 'CANCEL'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ],
                );
              },
            );
          },
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
            context
                .read<ProductCartBloc>()
                .add(RemoveFromCart(product: uniqueItems[index]));
            setState(() {
              uniqueItems.removeAt(index);
            });
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
