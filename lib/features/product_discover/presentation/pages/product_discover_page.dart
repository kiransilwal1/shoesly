import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/features/product_discover/presentation/widgets/product_card.dart';
import 'package:shoesly/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shoesly/features/product_detail/presentation/pages/product_detail_page.dart';
import '../bloc/product_discover_bloc.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import 'product_filter.dart';
import '../widgets/brand_search.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/shimmer_discover_page.dart';

class ProductDiscoverPage extends StatefulWidget {
  const ProductDiscoverPage({super.key});

  @override
  State<ProductDiscoverPage> createState() => _ProductDiscoverPageState();
}

class _ProductDiscoverPageState extends State<ProductDiscoverPage> {
  @override
  void initState() {
    context.read<ProductDiscoverBloc>().add(ProductDiscoverInitiated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(size.width.toString());
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size(0, 80),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 16, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterByBrand(),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<ProductDiscoverBloc, ProductDiscoverState>(
              listener: (context, state) {
                if (state is ProductDiscoverFailure) {
                  showErrorPopup(context, state.errorMessage, 'BACK');
                }
              },
              builder: (context, state) {
                if (state is ProductDiscoverSuccess) {
                  return Expanded(
                      child: state.productData.products.isNotEmpty
                          ? GridView.builder(
                              itemCount: state.productData.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: size.width ~/ 170,
                                      mainAxisExtent: 225,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 30),
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                    onTap: () {
                                      context.read<ProductDetailBloc>().add(
                                          ProductDetailLoadEvent(
                                              id: state.productData
                                                  .products[index].id));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage()),
                                      );
                                    },
                                    child: ProductCard(
                                        height: 142,
                                        width: 150,
                                        imageUrl: state.productData
                                            .products[index].productImageUrl,
                                        iconUrl: state.productData
                                            .products[index].brandImageUrl,
                                        title: state
                                            .productData.products[index].title,
                                        averageRating: state.productData
                                            .products[index].averageRating,
                                        ratingCounts: state.productData
                                            .products[index].reviewCount,
                                        price: state.productData.products[index]
                                            .price));
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/404.gif',
                                    height: size.width * 0.4,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'No Products Found',
                                    style: AppTheme.headline600,
                                  ),
                                ],
                              ),
                            ));
                } else {
                  debugPrint(state.toString());
                  return Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DicoverPageShimmer(size: size)),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<ProductDiscoverBloc, ProductDiscoverState>(
        builder: (context, state) {
          if (state is ProductDiscoverSuccess) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: PrimaryButton(
                isDisabled: false,
                style: const LeadingIconStyle(
                  text: 'Filter',
                  leadingIconImagePath: 'assets/icons/setting.svg',
                ),
                onPressed: () {
                  context.read<ProductDiscoverBloc>().add(PrepareFilterParams(
                      productData: state.productData,
                      globalProductData: state.globalProductData));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductFilterPage()),
                  );
                },
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
