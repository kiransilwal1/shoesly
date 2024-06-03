import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_theme.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/pages/cart_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: AppBar(
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
            icon: SvgPicture.asset(
              'assets/icons/bag.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              context.read<CartBloc>().add(GetCartEvent());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
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
