import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceRangeChanged,
  });

  final double minPrice;
  final double maxPrice;
  final void Function(double minValue, double maxValue) onPriceRangeChanged;

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      widget.minPrice,
      widget.minPrice + (widget.maxPrice - widget.minPrice) / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.minPrice,
          max: widget.maxPrice,
          divisions: 100,
          activeColor: AppTheme.neutral500,
          inactiveColor: AppTheme.neutral100,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              widget.onPriceRangeChanged(
                  values.start, values.end); // Notify parent
            });
          },
        ),
      ],
    );
  }
}
