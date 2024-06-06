import 'package:flutter/material.dart';

import '../../../../core/common/theme/app_theme.dart';

class ChipSelector extends StatefulWidget {
  const ChipSelector({
    super.key,
    required this.chipText,
    required this.onTextSelected,
  });

  final List<String> chipText;
  final ValueChanged<String?> onTextSelected;

  @override
  State<ChipSelector> createState() => _ChipSelectorState();
}

class _ChipSelectorState extends State<ChipSelector> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (String text in widget.chipText)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedText = (_selectedText == text) ? null : text;
                      widget.onTextSelected(_selectedText);
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _selectedText == text
                          ? AppTheme.neutral500
                          : Colors.transparent,
                      border: Border.all(
                        color: _selectedText == text
                            ? AppTheme.neutral500
                            : AppTheme.neutral200,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            text,
                            style: AppTheme.headline400.copyWith(
                              color: _selectedText == text
                                  ? AppTheme.neutral0
                                  : AppTheme.neutral500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
