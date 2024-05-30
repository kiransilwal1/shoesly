import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/alert.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/primary_buttons.dart';
import 'package:shoesly/core/widgets/product_card.dart';
import 'package:shoesly/features/discover/domain/entities/shoes.dart';
import 'package:shoesly/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoesly/features/product-detail/presentation/pages/product_detail.dart';
import 'package:shoesly/features/product_filter/presentation/pages/product_filter.dart';

import '../../../../core/utils/snackbar.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final int index = 0;

  @override
  void initState() {
    super.initState();
    context.read<DiscoverBloc>().add(FetchAllShoes());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is DiscoverSuccess) {
          Set<String> uniqueBrands = Set<String>();
          uniqueBrands.add("All");
          for (var shoes in state.shoes) {
            uniqueBrands.add(shoes.brandName);
          }
          print(uniqueBrands);
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                        icon: SvgPicture.asset('assets/icons/bag.svg',
                            height: 24),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String text in uniqueBrands)
                          MinimalButton(
                              isDisabled: false,
                              style: LabelButtonStyle(text: text))
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                      builder: (context) => ProductDetail()),
                                );
                              },
                              child: ProductCard(
                                width: 150,
                                height: 150,
                                imageUrl: state.shoes[index].thumbnailImageUrl,
                                iconUrl: state.shoes[index].brandImageUrl,
                                title: state.shoes[index].description,
                                averageRating: state.shoes[index].averageRating,
                                price: state.shoes[index].salePrice,
                                ratingCounts: state.shoes[index].reviewCount,
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(32.0),
              child: PrimaryButton(
                isDisabled: false,
                style: const LeadingIconStyle(
                    text: 'Filter',
                    leadingIconImagePath: 'assets/icons/filter.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductFilterPage()),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }

  getRating({required List<Review> reviews}) {}
}
