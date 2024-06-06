import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/common/widgets/standard_app_bar.dart';
import 'package:shoesly/features/product_discover/presentation/bloc/product_discover_bloc.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/features/product_discover/domain/entities/color_entites.dart';
import 'package:shoesly/features/product_discover/presentation/widgets/bottom_sheet.dart';
import '../../../../core/common/widgets/alert.dart';
import '../widgets/brand_selector.dart';
import '../widgets/chip_selector.dart';
import '../widgets/color_selector.dart';
import '../widgets/price_range_slider.dart';
import '../widgets/shimmer_filter_page.dart';

// ignore: must_be_immutable
class ProductFilterPage extends StatelessWidget {
  ProductFilterPage({super.key});

  final List<String> sortButtonText = [
    'Most recent',
    'Lowest price',
    'Highest reviews'
  ];

  final List<String> genderText = ['Man', 'Woman', 'Unisex'];

  ColorEntity? _selectedColor;

  String? _selectedGender;

  String? _selectedSortBy;

  double? _minPrice;

  double? _maxPrice;

  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDiscoverBloc, ProductDiscoverState>(
      listener: (context, state) {
        if (state is ProductFilterFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is FilterParamSuccess) {
          return Scaffold(
              bottomSheet: BottomSheetFilterPage(
                  selectedId: _selectedId,
                  selectedColor: _selectedColor,
                  selectedGender: _selectedGender,
                  maxPrice: _maxPrice,
                  minPrice: _minPrice,
                  selectedSortBy: _selectedSortBy),
              appBar: PreferredSize(
                preferredSize: Size(0, 80),
                child: StandardAppBar(
                  title: 'Filter',
                  onBack: () {
                    context
                        .read<ProductDiscoverBloc>()
                        .add(ProductDiscoverInitiated());
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Brands',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: BrandSelectorView(
                            brands: state.filterEntity.brands,
                            onSelected: (value) {
                              _selectedId = value;
                              debugPrint(_selectedId);
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Price Range',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //TODO: The design needs to be changed according to the actual design
                      PriceRangeSlider(
                        maxPrice: state.filterEntity.maxPrice,
                        minPrice: state.filterEntity.minPrice,
                        onPriceRangeChanged:
                            (double minPrice, double maxPrice) {
                          _minPrice = minPrice;
                          _maxPrice = maxPrice;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Sort By',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ChipSelector(
                        chipText: sortButtonText,
                        onTextSelected: (String? selectedSortBy) {
                          _selectedSortBy = selectedSortBy;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Gender',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      //TODO: Need to add gender in Supabase
                      ChipSelector(
                        chipText: genderText,
                        onTextSelected: (String? selectedGender) {
                          _selectedGender = selectedGender;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Color',
                        style: AppTheme.headline400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      // _colorSelector(colorCodes: state.filterEntity.colorCodes),
                      ColorSelector(
                        colorList: state.filterEntity.colorCodes,
                        onColorSelected: (ColorEntity? selectedColor) {
                          _selectedColor = selectedColor;
                        },
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ));
        } else {
          return const Scaffold(
            body: FilterPageShimmer(),
          );
        }
      },
    );
  }
}
