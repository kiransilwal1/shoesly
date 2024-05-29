import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/theme/app_theme.dart';
import 'package:shoesly/core/widgets/buttons/button_styles.dart';
import 'package:shoesly/core/widgets/buttons/minimal_buttons.dart';
import 'package:shoesly/core/widgets/buttons/primary_buttons.dart';
import 'package:shoesly/core/widgets/product_card.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({super.key});

  final List<String> filterText = ["All", "Nike", "Jordan", "Adidas", "Rebook"];
  final int index = 0;

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
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (size.width ~/ 180),
                  mainAxisExtent: 250,
                ),
                itemBuilder: (_, index) {
                  return const SizedBox(
                      height: 300,
                      child: ProductCard(
                        width: 150,
                        height: 150,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(32.0),
        child: PrimaryButton(
            isDisabled: false,
            style: LeadingIconStyle(
                text: 'Filter',
                leadingIconImagePath: 'assets/icons/filter.png')),
      ),
    );
  }
}
