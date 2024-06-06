import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesly/core/constants/constants.dart';
import 'package:shoesly/core/common/network/connection_checker.dart';
import 'package:shoesly/features/product_cart/data/datasources/cart_local_data.dart';
import 'package:shoesly/features/product_cart/data/repositories/cart_repo_impl.dart';
import 'package:shoesly/features/product_cart/domain/usecases/add_product_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/bulk_add_to_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/delete_from_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/remove_from_cart.dart';
import 'package:shoesly/features/product_cart/domain/usecases/view_cart.dart';
import 'package:shoesly/features/product_detail/data/datasources/product_detail_remote.dart';
import 'package:shoesly/features/product_detail/data/repositories/product_detail_repo_impl.dart';
import 'package:shoesly/features/product_detail/domain/usecases/product_detail_load_usecase.dart';
import 'package:shoesly/features/product_discover/data/datasources/product_remote_datasource.dart';
import 'package:shoesly/features/product_discover/data/repositories/product_repo_impl.dart';
import 'package:shoesly/features/product_discover/domain/usecases/filter_params_collect.dart';
import 'package:shoesly/features/product_discover/domain/usecases/filter_product_page_usecase.dart';
import 'package:shoesly/features/product_discover/domain/usecases/product_discover_usecase.dart';
import 'package:shoesly/features/product_discover/presentation/bloc/product_discover_bloc.dart';
import 'package:shoesly/features/product_payment/data/datasources/payment_remote_datasource.dart';
import 'package:shoesly/features/product_payment/data/repositories/payment_repo_impl.dart';
import 'package:shoesly/features/product_payment/domain/usecases/checkout_usecase.dart';
import 'package:shoesly/features/product_payment/domain/usecases/product_payment_initiate_useecase.dart';
import 'package:shoesly/features/product_payment/presentation/bloc/paywall_bloc.dart';
import 'package:shoesly/features/product_review/presentation/bloc/product_review_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/common/cubit/cart_status_cubit.dart';
import 'features/product_cart/presentation/bloc/product_cart_bloc.dart';
import 'features/product_detail/presentation/bloc/product_detail_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    return sharedPreferences;
  });

  getIt.registerSingletonAsync<SupabaseClient>(() async {
    await Supabase.initialize(
      url: Constants.kApiUrl,
      anonKey: Constants.kKey,
    );
    return SupabaseClient(Constants.kApiUrl, Constants.kKey);
  });

  getIt.registerSingleton<CartStatusCubit>(CartStatusCubit());

  getIt.registerFactory<ProductDetailRepoImpl>(() => ProductDetailRepoImpl(
        productDetailRemote: ProudctDetailRemote(
          db: getIt<SupabaseClient>(),
        ),
      ));

  getIt
      .registerFactory<ProductDetailLoadUseCase>(() => ProductDetailLoadUseCase(
            productDetailRepo: getIt<ProductDetailRepoImpl>(),
          ));

  getIt.registerFactory<ProductDetailBloc>(() => ProductDetailBloc(
        productDetailLoadUseCase: getIt<ProductDetailLoadUseCase>(),
      ));

  getIt.registerFactory<ProductCartRepoImpl>(() => ProductCartRepoImpl(
        cartLocalData: ProductCartLocalDataImpl(
          db: getIt<SharedPreferences>(),
        ),
      ));

  getIt.registerFactory<RemoveFromCartUseCase>(() => RemoveFromCartUseCase(
        productCartRepo: getIt<ProductCartRepoImpl>(),
      ));

  getIt.registerFactory<DeleteFromCartUseCase>(() => DeleteFromCartUseCase(
        productCartRepo: getIt<ProductCartRepoImpl>(),
      ));

  getIt.registerFactory<BulkAddToCartUseCase>(() => BulkAddToCartUseCase(
        productCartRepo: getIt<ProductCartRepoImpl>(),
      ));

  getIt.registerFactory<ViewCartUseCase>(() => ViewCartUseCase(
        productCartRepo: getIt<ProductCartRepoImpl>(),
      ));

  getIt.registerFactory<ProductAddToCartUseCase>(() => ProductAddToCartUseCase(
        cartRepo: getIt<ProductCartRepoImpl>(),
      ));

  getIt.registerFactory<ProductCartBloc>(() => ProductCartBloc(
        cartStatusCubit: getIt<CartStatusCubit>(),
        removeFromCartUseCase: getIt<RemoveFromCartUseCase>(),
        deleteFromCartUseCase: getIt<DeleteFromCartUseCase>(),
        bulkAddToCartUseCase: getIt<BulkAddToCartUseCase>(),
        viewCartUseCase: getIt<ViewCartUseCase>(),
        productAddToCart: getIt<ProductAddToCartUseCase>(),
      ));

  getIt.registerFactory<ProductPaymentBloc>(() => ProductPaymentBloc(
      checkOutUsecase: getIt<CheckoutUseCase>(),
      productPaymentInitiateUseecase: getIt<ProductPaymentInitiateUsecase>()));

  getIt.registerFactory<ProductReviewBloc>(() => ProductReviewBloc());

  getIt.registerFactory<ProductRepoImpl>(() => ProductRepoImpl(
        connectionChecker: ConnectionCheckerImpl(InternetConnection()),
        productRemoteDataSource: ProductRemoteDataSourceImpl(
          db: getIt<SupabaseClient>(),
        ),
      ));

  getIt
      .registerFactory<FilterProductPageUseCase>(() => FilterProductPageUseCase(
            productRepo: getIt<ProductRepoImpl>(),
          ));

  getIt.registerFactory<FilterParamsCollectUseCase>(
      () => FilterParamsCollectUseCase(
            productRepo: getIt<ProductRepoImpl>(),
          ));

  getIt.registerFactory<ProductDiscoverUsecase>(() => ProductDiscoverUsecase(
        productRepo: getIt<ProductRepoImpl>(),
      ));

  getIt.registerFactory<ProductDiscoverBloc>(() => ProductDiscoverBloc(
        filterProductPageUseCase: getIt<FilterProductPageUseCase>(),
        filterParamsCollectUseCase: getIt<FilterParamsCollectUseCase>(),
        productDiscoverUsecase: getIt<ProductDiscoverUsecase>(),
      ));
  getIt.registerFactory<CheckoutUseCase>(
    () => CheckoutUseCase(
      paymentRepo: getIt<PaymentRepoImpl>(),
    ),
  );
  getIt.registerFactory<ProductPaymentInitiateUsecase>(
    () => ProductPaymentInitiateUsecase(
      paymentRepo: getIt<PaymentRepoImpl>(),
    ),
  );
  getIt.registerFactory<PaymentRepoImpl>(() => PaymentRepoImpl(
      connectionChecker: ConnectionCheckerImpl(InternetConnection()),
      paymentRemoteDataSource: PaymentRemoteDataSourceImpl(
          db: getIt<SupabaseClient>(), cache: getIt<SharedPreferences>())));
}
