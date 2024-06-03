import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SizeOptionsView extends StatelessWidget {
  const SizeOptionsView({
    super.key,
    required this.sizes,
  });

  final List<double> sizes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (double size in sizes)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: SizeButton(size: size),
            ),
        ],
      ),
    );
  }
}

class SizeButton extends StatefulWidget {
  const SizeButton({
    super.key,
    required this.size,
  });

  final double size;

  @override
  State<SizeButton> createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed ? AppTheme.neutral500 : AppTheme.neutral100,
          border: Border.all(
            color: !_isPressed ? AppTheme.neutral200 : AppTheme.neutral500,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text(
            widget.size.toStringAsFixed(
                widget.size.truncateToDouble() == widget.size ? 0 : 1),
            style: AppTheme.headline300.copyWith(
                color: !_isPressed ? AppTheme.neutral400 : AppTheme.neutral0),
          ),
        ),
      ),
    );
  }
}
