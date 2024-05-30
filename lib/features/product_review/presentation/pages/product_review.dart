import 'package:flutter/material.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/reviews.dart';

class ProductReviewPage extends StatelessWidget {
  ProductReviewPage({super.key});

  final List<String> filterText = [
    "All",
    "5 Star",
    "4 Star",
    "3 Star",
    "2 Star",
    "1 Star"
  ];
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/icons/star.png',
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '4.5',
                    style: AppTheme.headline300
                        .copyWith(color: AppTheme.neutral500, fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
        leading: MinimalButton(
          isDisabled: false,
          style: IconOnlyStyle(iconImagePath: 'assets/icons/back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Review (1045)',
          style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String text in filterText)
                  MinimalButton(
                      isDisabled: !(filterText.indexOf(text) == index),
                      style: LabelButtonStyle(text: text))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                    SizedBox(
                      height: 16,
                    ),
                    Reviews(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
