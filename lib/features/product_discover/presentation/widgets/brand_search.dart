import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/features/product_discover/presentation/bloc/product_discover_bloc.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/minimal_buttons.dart';

class FilterByBrand extends StatefulWidget {
  const FilterByBrand({
    super.key,
  });

  @override
  State<FilterByBrand> createState() => _FilterByBrandState();
}

class _FilterByBrandState extends State<FilterByBrand> {
  final ScrollController _scrollController = ScrollController();

  String? selectedBrand = 'All';
  List<String> brandList = [
    'All',
    'Adidas',
    'Reboook',
    'Puma',
    'Jordan',
    'Nike',
    'Vans'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProductDiscoverBloc, ProductDiscoverState>(
            builder: (context, state) {
              if (state is ProductDiscoverSuccess) {
                return Row(
                  children: [
                    for (String text in brandList)
                      MinimalButton(
                          isDisabled: text != selectedBrand,
                          onPressed: () {
                            setState(() {
                              selectedBrand = text;
                            });
                            context.read<ProductDiscoverBloc>().add(
                                FilterButtonPressed(
                                    shoeBrand: text,
                                    globalData: state.globalProductData,
                                    stateData: state.productData));

                            // _scrollToPosition(
                            //     _scrollController.position.maxScrollExtent /
                            //         buttonTexts.length);
                          },
                          style: LabelButtonStyle(text: text)),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
