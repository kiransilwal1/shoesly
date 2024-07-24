import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/features/product_cart/presentation/bloc/product_cart_bloc.dart';
import 'package:shoesly/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shoesly/features/product_discover/presentation/bloc/product_discover_bloc.dart';
import 'package:shoesly/features/product_discover/presentation/pages/product_discover_page.dart';
import 'package:shoesly/features/product_payment/presentation/bloc/paywall_bloc.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
import 'core/common/cubit/cart_status_cubit.dart';
import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await GetIt.instance.allReady();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<ProductDiscoverBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<ProductDetailBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<ProductCartBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<CartStatusCubit>(),
      ),
      BlocProvider(
        create: (_) => getIt<ProductReviewBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<ProductPaymentBloc>(),
      ),
    ],
    child: const Shoesly(),
  ));
}

class Shoesly extends StatelessWidget {
  const Shoesly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppTheme.neutral0),
      title: 'Shoesly',
      debugShowCheckedModeBanner: false,
      home: const ProductDiscoverPage(),
    );
  }
}
