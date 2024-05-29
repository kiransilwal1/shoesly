import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/secondary_buttons.dart';

import '../../../../core/widgets/buttons/primary_buttons.dart';

class ProductFilterPage extends StatelessWidget {
  ProductFilterPage({super.key});

  final List<String> sortButtonText = [
    'Most Recent',
    'Lowest Price',
    'Highest Price'
  ];

  final List<String> genderText = ['Man', 'Woman', 'Unisex'];
  final List<String> colorText = ['Black', 'White', 'Red'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomSheet: Container(
          height: 90,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SecondaryButton(
                  isDisabled: false,
                  style: const LabelButtonStyle(text: 'RESET (4)'),
                  onPressed: () {},
                ),
                PrimaryButton(
                  isDisabled: false,
                  style: const LabelButtonStyle(text: 'APPLY'),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 60,
          leading: MinimalButton(
            isDisabled: false,
            style: const IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Filter',
            style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
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
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BrandListView(),
                    BrandListView(),
                    BrandListView(),
                    BrandListView(),
                    BrandListView(),
                    BrandListView(),
                  ],
                ),
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
              //TODO: Create custom slider. Syncfusion slider check
              PriceRangeSilder(),
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
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (String buttonText in sortButtonText)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SecondaryButton(
                              isDisabled: false,
                              style: LabelButtonStyle(text: buttonText)),
                        )
                    ],
                  ),
                ),
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
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (String buttonText in genderText)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SecondaryButton(
                              isDisabled: false,
                              style: LabelButtonStyle(text: buttonText)),
                        )
                    ],
                  ),
                ),
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
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (String buttonText in colorText)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SecondaryButton(
                              isDisabled: false,
                              style: LeadingIconStyle(
                                  text: buttonText,
                                  leadingIconImagePath:
                                      'assets/icons/red-color.png')),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class BrandListView extends StatelessWidget {
  const BrandListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.neutral100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  'assets/icons/nike.svg',
                  color: AppTheme.neutral500,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'NIKE',
                  style:
                      AppTheme.headline300.copyWith(color: AppTheme.neutral500),
                ),
                Text(
                  '1001 Items',
                  style: AppTheme.body10.copyWith(color: AppTheme.neutral300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PriceRangeSilder extends StatefulWidget {
  @override
  _PriceRangeSilderState createState() => _PriceRangeSilderState();
}

class _PriceRangeSilderState extends State<PriceRangeSilder> {
  RangeValues _currentRangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 1750,
          divisions: 100,
          activeColor: AppTheme.neutral500,
          inactiveColor: AppTheme.neutral100,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ],
    );
  }
}
