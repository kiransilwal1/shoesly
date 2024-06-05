// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesly/core/constants/constants.dart';
import 'package:shoesly/core/cubit/cart_status_cubit.dart';
import 'package:shoesly/core/network/connection_checker.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/data/repositories/cart_repo_impl.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/bulk_add_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/delete_from_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/remove_from_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/view_cart.dart';
import 'package:shoesly/features/product_cart/presentation/bloc/product_cart_bloc.dart';
import 'package:shoesly/features/product_detail/data/datasources/product_detail_remote.dart';
import 'package:shoesly/features/product_detail/data/repositories/product_detail_repo_impl.dart';
import 'package:shoesly/features/product_detail/domain/usecases/product_detail_load_usecase.dart';
import 'package:shoesly/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/features/product_discover/data/repositories/product_repo_impl.dart';
import 'package:shoesly/features/product_discover/domain/usecases/filter_params_collect.dart';
import 'package:shoesly/features/product_discover/domain/usecases/filter_product_page_usecase.dart';
import 'package:shoesly/features/product_discover/domain/usecases/product_discover_usecase.dart';
import 'package:shoesly/features/product_discover/presentation/pages/product_discover_page.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
// import 'package:shoesly/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/product_discover/presentation/bloc/product_discover_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  // );
  final sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  await Supabase.initialize(
    url: Constants.kApiUrl,
    anonKey: Constants.kKey,
  );
  final cartStatusCubit = CartStatusCubit();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => cartStatusCubit),
      BlocProvider(
          create: (_) => ProductDetailBloc(
                  productDetailLoadUseCase: ProductDetailLoadUseCase(
                      productDetailRepo: ProductDetailRepoImpl(
                          productDetailRemote: ProudctDetailRemote(
                              db: SupabaseClient(
                Constants.kApiUrl,
                Constants.kKey,
              )))))),
      BlocProvider(
        create: (_) => ProductCartBloc(
          cartStatusCubit: cartStatusCubit,
          removeFromCartUseCase: RemoveFromCartUseCase(
              productCartRepo: ProductCartRepoImpl(
                  cartLocalData:
                      ProductCartLocalDataImpl(db: sharedPreferences))),
          deleteFromCartUseCase: DeleteFromCartUseCase(
              productCartRepo: ProductCartRepoImpl(
                  cartLocalData:
                      ProductCartLocalDataImpl(db: sharedPreferences))),
          bulkAddToCartUseCase: BulkAddToCartUseCase(
              productCartRepo: ProductCartRepoImpl(
                  cartLocalData:
                      ProductCartLocalDataImpl(db: sharedPreferences))),
          viewCartUseCase: ViewCartUseCase(
              productCartRepo: ProductCartRepoImpl(
                  cartLocalData:
                      ProductCartLocalDataImpl(db: sharedPreferences))),
          productAddToCart: ProductAddToCartUseCase(
            cartRepo: ProductCartRepoImpl(
              cartLocalData: ProductCartLocalDataImpl(db: sharedPreferences),
            ),
          ),
        ),
      ),
      BlocProvider(
        create: (_) => ProductReviewBloc(),
      ),
      BlocProvider(
        create: (_) => ProductDiscoverBloc(
          filterProductPageUseCase: FilterProductPageUseCase(
              productRepo: ProductRepoImpl(
                  connectionChecker:
                      ConnectionCheckerImpl(InternetConnection()),
                  productRemoteDataSource: ProductRemoteDataSourceImpl(
                      db: SupabaseClient(
                    Constants.kApiUrl,
                    Constants.kKey,
                  )))),
          filterParamsCollectUseCase: FilterParamsCollectUseCase(
              productRepo: ProductRepoImpl(
                  connectionChecker:
                      ConnectionCheckerImpl(InternetConnection()),
                  productRemoteDataSource: ProductRemoteDataSourceImpl(
                      db: SupabaseClient(
                    Constants.kApiUrl,
                    Constants.kKey,
                  )))),
          productDiscoverUsecase: ProductDiscoverUsecase(
            productRepo: ProductRepoImpl(
              connectionChecker: ConnectionCheckerImpl(InternetConnection()),
              productRemoteDataSource: ProductRemoteDataSourceImpl(
                db: SupabaseClient(
                  Constants.kApiUrl,
                  Constants.kKey,
                ),
              ),
            ),
          ),
        ),
      )
    ],
    child: const Shoesly(),
  ));
}

class Shoesly extends StatelessWidget {
  const Shoesly({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shoesly',
      debugShowCheckedModeBanner: false,
      home: ProductDiscoverPage(),
    );
  }
}
