import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/primary_buttons.dart';
import '../../../../core/common/widgets/buttons/secondary_buttons.dart';
import '../../domain/entities/color_entites.dart';
import '../bloc/product_discover_bloc.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
    required String? selectedId,
    required ColorEntity? selectedColor,
    required String? selectedGender,
    required double? maxPrice,
    required double? minPrice,
    required String? selectedSortBy,
  })  : _selectedId = selectedId,
        _selectedColor = selectedColor,
        _selectedGender = selectedGender,
        _maxPrice = maxPrice,
        _minPrice = minPrice,
        _selectedSortBy = selectedSortBy;

  final String? _selectedId;
  final ColorEntity? _selectedColor;
  final String? _selectedGender;
  final double? _maxPrice;
  final double? _minPrice;
  final String? _selectedSortBy;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
