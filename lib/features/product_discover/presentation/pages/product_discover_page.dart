import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/widgets/product_card.dart';
import 'package:shoesly/features/product_detail_v2/presentation/bloc/product_detail_v2_bloc.dart';
import 'package:shoesly/features/product_detail_v2/presentation/pages/product_detail_page.dart';
import '../../../../core/product_discover_bloc/product_discover_bloc.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../../../discover/presentation/bloc/discover_bloc.dart';
import '../../../product_filter/presentation/pages/product_filter.dart';
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
    context
        .read<ProductDiscoverBloc>()
        .add(FilterButtonPressed(shoeBrand: 'All'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(size.width.toString());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(100, 100),
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
              height: 36,
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
                    child: GridView.builder(
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width ~/ 170,
                          mainAxisExtent: 225,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                            onTap: () {
                              context.read<ProductDetailV2Bloc>().add(
                                  ProductDetailLoadEvent(
                                      id: state.products[index].id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage()),
                              );
                            },
                            child: ProductCard(
                                height: 142,
                                width: 150,
                                imageUrl: state.products[index].productImageUrl,
                                iconUrl: state.products[index].brandImageUrl,
                                title: state.products[index].title,
                                averageRating:
                                    state.products[index].averageRating,
                                ratingCounts: state.products[index].reviewCount,
                                price: state.products[index].price));
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: DicoverPageShimmer(size: size),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: PrimaryButton(
          isDisabled: false,
          style: const LeadingIconStyle(
            text: 'Filter',
            leadingIconImagePath: 'assets/icons/setting.svg',
          ),
          onPressed: () {
            context.read<DiscoverBloc>().add(FilterPressed());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductFilterPage()),
            );
          },
        ),
      ),
    );
  }
}
