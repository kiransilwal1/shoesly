import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/entities/brands.dart';
import 'package:shoesly/features/product_discover/presentation/bloc/product_discover_bloc.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/core/common/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/common/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/common/widgets/buttons/secondary_buttons.dart';
import 'package:shoesly/features/product_discover/domain/entities/color_entites.dart';
import '../../../../core/common/widgets/alert.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
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
              bottomSheet: Container(
                height: 90,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: BlocBuilder<ProductDiscoverBloc, ProductDiscoverState>(
                    builder: (context, state) {
                      if (state is FilterParamSuccess) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //TODO: Need to remove hard coded reset
                            SecondaryButton(
                              isDisabled: false,
                              style: const LabelButtonStyle(text: 'RESET'),
                              onPressed: () {},
                            ),
                            PrimaryButton(
                              isDisabled: false,
                              style: const LabelButtonStyle(text: 'APPLY'),
                              onPressed: () {
                                context.read<ProductDiscoverBloc>().add(
                                      FilterButtonPressed(
                                        shoeBrand: _selectedId ?? 'All',
                                        color: _selectedColor == null
                                            ? 'All'
                                            : _selectedColor!.colorCode,
                                        gender: _selectedGender,
                                        maxPrice: _maxPrice,
                                        minPrice: _minPrice,
                                        sortBy: _selectedSortBy,
                                        globalData: state.globalData,
                                        stateData: state.localData,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
              appBar: AppBar(
                scrolledUnderElevation: 0.0,
                toolbarHeight: 60,
                leading: _backButton(context),
                title: Text(
                  'Filter',
                  style:
                      AppTheme.headline400.copyWith(color: AppTheme.neutral500),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
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
                      _brandSelector(brands: state.filterEntity.brands),
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
                      _priceRangeSelector(
                          maxPrice: state.filterEntity.maxPrice,
                          minPrice: state.filterEntity.minPrice),
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
                      _sortyBySelector(),

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
                      _genderSelector(),
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
                      _colorSelector(colorCodes: state.filterEntity.colorCodes),
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

  SizedBox _colorSelector({required List<ColorEntity> colorCodes}) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ColorSelector(
          colorList: colorCodes,
          onColorSelected: (ColorEntity? selectedColor) {
            _selectedColor = selectedColor;
          },
        ),
      ),
    );
  }

  Widget _sortyBySelector() {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ChipSelector(
            chipText: sortButtonText,
            onTextSelected: (String? selectedSortBy) {
              _selectedSortBy = selectedSortBy;
            },
          )),
    );
  }

  Widget _genderSelector() {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ChipSelector(
            chipText: genderText,
            onTextSelected: (String? selectedGender) {
              _selectedGender = selectedGender;
            },
          )),
    );
  }

  PriceRangeSlider _priceRangeSelector(
      {required double maxPrice, required double minPrice}) {
    return PriceRangeSlider(
      maxPrice: maxPrice,
      minPrice: minPrice,
      onPriceRangeChanged: (double minPrice, double maxPrice) {
        _minPrice = minPrice;
        _maxPrice = maxPrice;
      },
    );
  }

  Widget _brandSelector({required List<Brand> brands}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BrandSelectorView(
          brands: brands,
          onSelected: (value) {
            _selectedId = value;
            debugPrint(_selectedId);
          }),
    );
  }

  Widget _backButton(BuildContext context) {
    return MinimalButton(
      isDisabled: false,
      style: const IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
      onPressed: () {
        context.read<ProductDiscoverBloc>().add(ProductDiscoverInitiated());
        Navigator.pop(context);
      },
    );
  }
}
