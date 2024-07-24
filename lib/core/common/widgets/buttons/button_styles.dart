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

/// So there will be (4 * 3) = 12 different button variants.

abstract class ButtonStyles {
  const ButtonStyles();
}

class LabelButtonStyle extends ButtonStyles {
  final String text;
  const LabelButtonStyle({required this.text});
}

class LeadingIconStyle extends ButtonStyles {
  final String text;
  final String leadingIconImagePath;
  const LeadingIconStyle(
      {required this.text, required this.leadingIconImagePath});
}

class TrailingIconStyle extends ButtonStyles {
  final String text;
  final String trailingIconImagePath;
  const TrailingIconStyle(
      {required this.text, required this.trailingIconImagePath});
}

class IconOnlyStyle extends ButtonStyles {
  final String iconImagePath;
  const IconOnlyStyle({required this.iconImagePath});
}
