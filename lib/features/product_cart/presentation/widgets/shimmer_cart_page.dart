import 'package:flutter/material.dart';
import 'package:shoesly/core/widgets/shimmers/shimmer_container_rounded.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/minimal_buttons.dart';

class ShimmerCartPage extends StatelessWidget {
  const ShimmerCartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          'Cart',
          style: AppTheme.headline400.copyWith(color: AppTheme.neutral500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ShimmerContainerRounded(
                      height: 100, width: size.width * 0.9),
                ),
              ]),
        ),
      ),
    );
  }
}
