import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';
import '../../domain/entities/color_entites.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.colorList,
    required this.onColorSelected,
  });

  final List<ColorEntity> colorList;
  final ValueChanged<ColorEntity?> onColorSelected;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  ColorEntity? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (ColorEntity color in widget.colorList)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = (_selectedColor == color) ? null : color;
                  // context.read<FilterCountBloc>().add(AddFilterEvent(1));
                  widget.onColorSelected(_selectedColor);
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: _selectedColor == color
                        ? AppTheme.neutral500
                        : AppTheme.neutral200,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: hexStringToColor(color.colorCode),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.neutral200,
                            width: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        color.name,
                        style: AppTheme.headline400.copyWith(
                          color: AppTheme.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '').replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add the alpha value if not provided
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
