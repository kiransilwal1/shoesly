import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesly/core/constants/constants.dart';
import 'package:shoesly/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:shoesly/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:shoesly/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:shoesly/features/cart/domain/usecases/swipe_to_delete_usecase.dart';
import 'package:shoesly/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoesly/features/discover/data/datasources/shoe_remote_datasource.dart';
import 'package:shoesly/features/discover/data/repositories/shoe_repo_impl.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filter_data.dart';
import 'package:shoesly/features/discover/domain/usecases/get_filtered_shoes.dart';
import 'package:shoesly/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/product-detail/data/datasources/product_detail_data_source.dart';
import 'package:shoesly/features/product-detail/data/repositories/product_detail_repo_impl.dart';
import 'package:shoesly/features/product-detail/domain/usecases/get_productdetail_usecase.dart';
import 'package:shoesly/features/product-detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/data/repositories/cart_repo_impl.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/view_cart.dart';
import 'package:shoesly/features/product_cart/presentation/bloc/product_cart_bloc.dart';
import 'package:shoesly/features/product_detail_v2/data/datasources/product_detail_remote.dart';
import 'package:shoesly/features/product_detail_v2/data/repositories/product_detail_repo_impl.dart';
import 'package:shoesly/features/product_detail_v2/domain/usecases/product_detail_load_usecase.dart';
import 'package:shoesly/features/product_detail_v2/presentation/bloc/product_detail_v2_bloc.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/features/product_discover/data/repositories/product_repo_impl.dart';
import 'package:shoesly/features/product_discover/domain/usecases/product_discover_usecase.dart';
import 'package:shoesly/features/product_discover/presentation/pages/product_discover_page.dart';
import 'package:shoesly/features/product_filter/data/datasources/product_filter_datasource.dart';
import 'package:shoesly/features/product_filter/data/repositories/product_filter_repo_impl.dart';
import 'package:shoesly/features/product_filter/domain/usecases/collect_filter_brands.dart';
import 'package:shoesly/features/product_filter/domain/usecases/filter_page_usecase.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
import 'package:shoesly/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/product_discover_bloc/product_discover_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  await Supabase.initialize(
    url: Constants.kApiUrl,
    anonKey: Constants.kKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => ProductDetailV2Bloc(
                  productDetailLoadUseCase: ProductDetailLoadUseCase(
                      productDetailRepo: ProductDetailRepoImplV2(
                          productDetailRemote: ProudctDetailRemote(
                              db: SupabaseClient(
                Constants.kApiUrl,
                Constants.kKey,
              )))))),
      BlocProvider(
        create: (_) => ProductCartBloc(
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
        create: (_) => DiscoverBloc(
          getFilterShoes: GetFilterShoes(
            shoeRepo: ShoeRepoImpl(
              shoeRemoteDataSource: ShoeRemoteDataSourceImpl(
                db: SupabaseClient(
                  Constants.kApiUrl,
                  Constants.kKey,
                ),
              ),
            ),
          ),
          getFilterParams: GetFilterParams(
            shoeRepo: ShoeRepoImpl(
              shoeRemoteDataSource: ShoeRemoteDataSourceImpl(
                db: SupabaseClient(
                  Constants.kApiUrl,
                  Constants.kKey,
                ),
              ),
            ),
          ),
        ),
      ),
      BlocProvider(
        create: (_) => ProductDetailBloc(
          productDetailUseCase: ProductDetailUseCase(
            productDetailRepo: ProductDetailRepoImpl(
              productDetailDataSource: ProductDetailDataSourceImpl(
                db: SupabaseClient(
                  Constants.kApiUrl,
                  Constants.kKey,
                ),
              ),
            ),
          ),
        ),
      ),
      BlocProvider(
        create: (_) => ProductReviewBloc(),
      ),
      BlocProvider(
        create: (_) => ProductDiscoverBloc(
          productDiscoverUsecase: ProductDiscoverUsecase(
            productRepo: ProductRepoImpl(
              productRemoteDataSource: ProductRemoteDataSourceImpl(
                db: SupabaseClient(
                  Constants.kApiUrl,
                  Constants.kKey,
                ),
              ),
            ),
          ),
          brandFilterCollectionUsecase: BrandFilterCollectionUsecase(
              productFilterRepo: ProductFilterRepoImpl(
                  productFilterRemoteDatasource:
                      ProductFilterRemoteDatasourceImpl(
            db: SupabaseClient(
              Constants.kApiUrl,
              Constants.kKey,
            ),
          ))),
          filterPageUsecase: FilterPageUsecase(
              productFilterRepo: ProductFilterRepoImpl(
                  productFilterRemoteDatasource:
                      ProductFilterRemoteDatasourceImpl(
            db: SupabaseClient(
              Constants.kApiUrl,
              Constants.kKey,
            ),
          ))),
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
    return MaterialApp(
      title: 'Shoesly',
      debugShowCheckedModeBanner: false,
      home: ProductDiscoverPage(),
    );
  }
}
