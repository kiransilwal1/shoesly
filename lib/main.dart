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
import 'package:shoesly/features/discover/presentation/pages/discover_page.dart';
import 'package:shoesly/features/product-detail/data/datasources/product_detail_data_source.dart';
import 'package:shoesly/features/product-detail/data/repositories/product_detail_repo_impl.dart';
import 'package:shoesly/features/product-detail/domain/usecases/get_productdetail_usecase.dart';
import 'package:shoesly/features/product-detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
import 'package:shoesly/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          create: (_) => CartBloc(
              swipeToDeleteUseCase: SwipeToDeleteUseCase(
                  cartRepo: CartRepoImpl(
                      cartLocalDataSource: CartLocalDataSourceImpl(
                          sharedPreferences: sharedPreferences))),
              removeFromCartUseCase: RemoveFromCartUseCase(
                  cartRepo: CartRepoImpl(
                      cartLocalDataSource: CartLocalDataSourceImpl(
                          sharedPreferences: sharedPreferences))),
              getCartUsecase: GetCartUsecase(
                  cartRepo: CartRepoImpl(
                      cartLocalDataSource: CartLocalDataSourceImpl(
                          sharedPreferences: sharedPreferences))),
              addToCartUsecase: AddToCartUsecase(
                  cartRepo: CartRepoImpl(
                      cartLocalDataSource: CartLocalDataSourceImpl(
                          sharedPreferences: sharedPreferences)))))
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
      home: DiscoverPage(),
    );
  }
}
