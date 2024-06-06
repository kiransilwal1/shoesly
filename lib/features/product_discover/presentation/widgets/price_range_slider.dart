import 'package:flutter/material.dart';
import 'package:shoesly/core/common/widgets/thumb_selector.dart';
import '../../../../core/common/theme/app_theme.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceRangeChanged,
  }) : super(key: key);

  final double minPrice;
  final double maxPrice;
  final void Function(double minValue, double maxValue) onPriceRangeChanged;

  @override
  // ignore: library_private_types_in_public_api
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late double _currentMinValue;
  late double _currentMaxValue;

  @override
  void initState() {
    super.initState();
    _currentMinValue = widget.minPrice;
    _currentMaxValue = widget.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 80, // Adjust height according to your needs
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //TODO: Thumb Separation can be maintained so that label do not overlap
              SliderTheme(
                data: const SliderThemeData(
                    rangeThumbShape: ThumbSilderBandW(),
                    minThumbSeparation: 30),
                child: RangeSlider(
                  values: RangeValues(_currentMinValue, _currentMaxValue),
                  min: widget.minPrice,
                  max: widget.maxPrice,
                  activeColor: AppTheme.neutral500,
                  inactiveColor: AppTheme.neutral100,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentMinValue = values.start;
                      _currentMaxValue = values.end;
                      widget.onPriceRangeChanged(
                          _currentMinValue, _currentMaxValue);
                    });
                  },
                ),
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.minPrice.toStringAsFixed(0)}',
                        style: AppTheme.headline200
                            .copyWith(color: AppTheme.neutral300),
                      ),
                      Text(
                        '\$${widget.maxPrice.toStringAsFixed(0)}',
                        style: AppTheme.headline200
                            .copyWith(color: AppTheme.neutral300),
                      )
                    ],
                  ),
                  //TODO: Need to Findout the exact padding so that the label is linearly displaced. currently 100 px used.
                  Positioned(
                      left: (size.width - 100) /
                          (widget.maxPrice - widget.minPrice) *
                          (_currentMinValue - widget.minPrice),
                      child: Text(
                        '\$${_currentMinValue.toStringAsFixed(0)}',
                        style: AppTheme.headline200,
                      )),
                  Positioned(
                      left: (size.width - 90) /
                          (widget.maxPrice - widget.minPrice) *
                          (_currentMaxValue - widget.minPrice),
                      child: Text(
                        '\$${_currentMaxValue.toStringAsFixed(0)}',
                        style: AppTheme.headline200,
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
