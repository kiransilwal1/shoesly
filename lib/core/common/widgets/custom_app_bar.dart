import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/features/product_cart/presentation/bloc/product_cart_bloc.dart';

import '../cubit/cart_status_cubit.dart';
import '../theme/app_theme.dart';
import '../../../features/product_cart/presentation/pages/cart_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 24, 30, 0),
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Discover',
            style: AppTheme.headline700.copyWith(color: AppTheme.neutral600),
          ),
        ),
        actions: [
          IconButton(
            icon: const CartStatusWidget(),
            onPressed: () {
              context.read<ProductCartBloc>().add(ViewCartEvent());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class CartStatusWidget extends StatelessWidget {
  const CartStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartStatusCubit, CartStatusState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CartStatusInitial) {
          return SvgPicture.asset(
            'assets/icons/bag.svg',
            width: 24,
            height: 24,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    'assets/icons/bag.svg',
                    width: 24,
                    height: 24,
                  ),
                  Positioned(
                      top: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.error500,
                          shape: BoxShape.circle,
                        ),
                      ))
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
