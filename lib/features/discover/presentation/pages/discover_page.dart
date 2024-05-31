import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/alert.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/primary_buttons.dart';
import 'package:shoesly/core/widgets/product_card.dart';

import 'package:shoesly/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/product-detail/presentation/pages/product_detail.dart';
import 'package:shoesly/features/discover/presentation/pages/product_filter.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final int index = 0;
  final List<String> brands = [
    'All',
    'VANS',
    'REEBOK',
    'PUMA',
    'ADIDAS',
    'JORDAN',
    'NIKE'
  ];
  @override
  void initState() {
    super.initState();
    context.read<DiscoverBloc>().add(FilterShoes(shoeBrand: 'All'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 75, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover',
                  style: AppTheme.headline700,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/bag.svg', height: 24),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<DiscoverBloc, DiscoverState>(
              listener: (context, state) {
                if (state is DiscoverFailure) {
                  showErrorPopup(context, state.errorMessage, 'BACK');
                }
                if (state is ShoeFilterFailure) {
                  showErrorPopup(context, state.errorMessage, 'BACK');
                }
              },
              builder: (context, state) {
                if (state is DiscoverSuccess) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (String text in brands)
                                MinimalButton(
                                  isDisabled:
                                      text == state.filterParams.shoeBrand
                                          ? false
                                          : true,
                                  style: LabelButtonStyle(text: text),
                                  onPressed: () {
                                    context
                                        .read<DiscoverBloc>()
                                        .add(FilterShoes(shoeBrand: text));
                                  },
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          //TODO: minimum width = 365 px for 2 columns grid
                          child: GridView.builder(
                            itemCount: state.shoes.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: (size.width ~/ 180),
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (_, index) {
                              // TODO: Calculating ratings on the app side due to availability of paid firebase plan

                              return SizedBox(
                                  height: 300,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetail()),
                                      );
                                    },
                                    child: ProductCard(
                                      width: 150,
                                      height: 150,
                                      imageUrl:
                                          state.shoes[index].thumbnailImageUrl,
                                      iconUrl: state.shoes[index].brandImageUrl,
                                      title: state.shoes[index].description,
                                      averageRating:
                                          state.shoes[index].averageRating,
                                      price: state.shoes[index].salePrice,
                                      ratingCounts:
                                          state.shoes[index].reviewCount,
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  print(state);
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: size.width * 0.8,
                          height: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 59,
                      ),
                      SizedBox(
                        height: 0.7 * size.height,
                        child: GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (size.width ~/ 180),
                                  mainAxisExtent: 150,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (_, index) {
                            // TODO: Calculating ratings on the app side due to availability of paid firebase plan

                            return SizedBox(
                              height: 150,
                              width: 150,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: PrimaryButton(
          isDisabled: false,
          style: const LeadingIconStyle(
              text: 'Filter', leadingIconImagePath: 'assets/icons/filter.png'),
          onPressed: () {
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
