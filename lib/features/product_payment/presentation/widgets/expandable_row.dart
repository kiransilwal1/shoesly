import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/theme/app_theme.dart';

class ExpandableWidget extends StatelessWidget {
  const ExpandableWidget({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO: expand when pressed on arrow-right
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.headline300,
              ),
              Text(
                description,
                style: AppTheme.body200,
              ),
            ],
          ),
          SvgPicture.asset('assets/icons/arrow-right.svg',
              colorFilter:
                  const ColorFilter.mode(AppTheme.neutral300, BlendMode.srcIn)),
        ],
      ),
    );
  }
}
