import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/common/theme/app_theme.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';

class AppBarProductDetailPage extends StatelessWidget {
  const AppBarProductDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: CartStatusWidget(),
          ),
        ],
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back-arrow.svg',
              colorFilter:
                  const ColorFilter.mode(AppTheme.neutral500, BlendMode.srcIn)),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
