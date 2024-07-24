import 'package:flutter/material.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';
import 'package:shoesly/core/common/widgets/buttons/button_styles.dart';

// ignore: must_be_immutable

///Mainly buttons can be catorized on the basis of variants and configurations.
/// 1. Variants
/// Variants are the major categorization critera. It determines whether the button is primary or secondary.
///    a. Primary
///    b. Secondary
///    c. text/minimal

/// 2. Configurations
/// Either the button has only label, button has icon at the leading or trailing position and button has Icon only
///    a. Label only
///    b. Leading Icon with Label
///    c. Trailing Icon with Label
///    d. Icon only

/// So there will be (4 * 3) = 12 different button variants. The style of the button shall be provided.

class MinimalButton extends StatelessWidget {
  final bool isDisabled;
  final ButtonStyles style;
  final VoidCallback? onPressed;
  Color? color;

  MinimalButton({
    Key? key,
    this.color,
    required this.isDisabled,
    required this.style,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    color = color ?? AppTheme.neutral500;
    if (style is IconOnlyStyle) {
      content = Image.asset(
        (style as IconOnlyStyle).iconImagePath,
        height: 24,
        color: AppTheme.neutral500,
      );
    } else if (style is LeadingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            (style as LeadingIconStyle).leadingIconImagePath,
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
          const SizedBox(width: 8),
          Text(
            (style as LeadingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
          ),
        ],
      );
    } else if (style is TrailingIconStyle) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (style as TrailingIconStyle).text,
            style: AppTheme.headline300.copyWith(color: AppTheme.neutral500),
          ),
          const SizedBox(width: 8),
          Image.asset(
            (style as TrailingIconStyle).trailingIconImagePath,
            width: 24,
            height: 24,
            color: AppTheme.neutral500,
          ),
        ],
      );
    } else if (style is LabelButtonStyle) {
      content = Text(
        (style as LabelButtonStyle).text,
        style: AppTheme.headline600
            .copyWith(color: isDisabled ? Colors.grey : color),
      );
    } else {
      throw ArgumentError('Invalid ButtonStyle');
    }

    return TextButton(
      onPressed: onPressed,
      child: content,
    );
  }
}
