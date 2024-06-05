import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SizeOptionsView extends StatefulWidget {
  const SizeOptionsView({
    super.key,
    required this.sizes,
    //TODO: Oh My god, too many prop drilling, need to optimize it later. Hate to use state for everything.
    required this.onSizeSelected,
  });

  final Function(double value) onSizeSelected;
  final List<double> sizes;

  @override
  _SizeOptionsViewState createState() => _SizeOptionsViewState();
}

class _SizeOptionsViewState extends State<SizeOptionsView> {
  double? _selectedSize;

  void _handleSizeSelected(double size) {
    setState(() {
      _selectedSize = size;
    });
    widget.onSizeSelected(size);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.sizes.map((size) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: SizeButton(
              size: size,
              isSelected: _selectedSize == size,
              onSelected: _handleSizeSelected,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onSelected,
  });

  final double size;
  final bool isSelected;
  final Function(double value) onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(size);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppTheme.neutral500 : AppTheme.neutral100,
          border: Border.all(
            color: isSelected ? AppTheme.neutral500 : AppTheme.neutral200,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text(
            size.toStringAsFixed(size.truncateToDouble() == size ? 0 : 1),
            style: AppTheme.headline300.copyWith(
              color: isSelected ? AppTheme.neutral0 : AppTheme.neutral400,
            ),
          ),
        ),
      ),
    );
  }
}
