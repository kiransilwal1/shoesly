import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';

class ProductFilterPage extends StatelessWidget {
  const ProductFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: const MinimalButton(
              isDisabled: false,
              style: IconOnlyStyle(iconImagePath: 'assets/icons/back.png')),
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
                height: 16,
              ),
              Row(
                children: [
                  Container(
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
                              style: AppTheme.headline300
                                  .copyWith(color: AppTheme.neutral500),
                            ),
                            Text(
                              '1001 Items',
                              style: AppTheme.body10
                                  .copyWith(color: AppTheme.neutral300),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
