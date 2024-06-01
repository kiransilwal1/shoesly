// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/secondary_buttons.dart';
import 'package:shoesly/features/discover/domain/entities/color_entites.dart';
import '../../../../core/widgets/alert.dart';
import '../../../../core/widgets/buttons/primary_buttons.dart';
import '../bloc/discover_bloc.dart';
import '../widgets/brand_selector.dart';
import '../widgets/chip_selector.dart';
import '../widgets/color_selector.dart';
import '../widgets/price_range_slider.dart';
import '../widgets/shimmer_filter_page.dart';

class ProductFilterPage extends StatelessWidget {
  ProductFilterPage({super.key});

  final List<String> sortButtonText = [
    'Most Recent',
    'Lowest Price',
    'Highest Price'
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
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is FilterFailure) {
          showErrorPopup(context, state.errorMessage, 'BACK');
        }
      },
      builder: (context, state) {
        if (state is FilterParamSuccess) {
          return Scaffold(
              bottomSheet: Container(
                height: 90,
                color: Colors.white,
                child: _bottomSheetWithButtons(context),
              ),
              appBar: AppBar(
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
                      _brandSelector(state),
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
                      _priceRangeSelector(state),
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
                      _colorSelector(state),
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

  SizedBox _colorSelector(FilterParamSuccess state) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ColorSelector(
          colorList: state.colorCodes,
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
            onTextSelected: (String? selectedGender) {
              _selectedGender = selectedGender;
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
            onTextSelected: (String? selectedSorting) {
              _selectedSortBy = selectedSorting;
            },
          )),
    );
  }

  PriceRangeSlider _priceRangeSelector(FilterParamSuccess state) {
    return PriceRangeSlider(
      maxPrice: state.maxPrice,
      minPrice: state.minPrice,
      onPriceRangeChanged: (double minPrice, double maxPrice) {
        _minPrice = minPrice;
        _maxPrice = maxPrice;
      },
    );
  }

  Widget _brandSelector(FilterParamSuccess state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BrandSelectorView(
          brands: state.brands,
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
        context.read<DiscoverBloc>().add(
              FilterShoes(
                  shoeBrand: _selectedId ?? 'All',
                  color: _selectedColor == null
                      ? 'All'
                      : _selectedColor!.colorCode,
                  gender: _selectedGender,
                  maxPrice: _maxPrice,
                  minPrice: _minPrice,
                  sortBy: _selectedSortBy),
            );
        Navigator.pop(context);
      },
    );
  }

  Widget _bottomSheetWithButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO: Need to remove hard coded reset
          SecondaryButton(
            isDisabled: false,
            style: const LabelButtonStyle(text: 'RESET (4)'),
            onPressed: () {},
          ),
          PrimaryButton(
            isDisabled: false,
            style: const LabelButtonStyle(text: 'APPLY'),
            onPressed: () {
              context.read<DiscoverBloc>().add(
                    FilterShoes(
                        shoeBrand: _selectedId ?? 'All',
                        color: _selectedColor == null
                            ? 'All'
                            : _selectedColor!.colorCode,
                        gender: _selectedGender,
                        maxPrice: _maxPrice,
                        minPrice: _minPrice,
                        sortBy: _selectedSortBy),
                  );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
