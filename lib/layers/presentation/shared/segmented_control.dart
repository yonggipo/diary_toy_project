import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../application/common/custom_string_convertible.dart';

typedef ValueChanged<T> = void Function(T value);

final class SegmentedControl<T extends CustomStringConvertible>
    extends StatefulWidget {
  const SegmentedControl({
    super.key,
    required this.values,
    required this.onValueChanged,
    this.selectedColor = Colors.black,
    this.unSelectedColor = Colors.black,
    this.selectedBackgroundColor = Colors.grey,
    this.unSelectedBackgroundColor = Colors.white,
  });

  final List<T> values;
  final ValueChanged<T> onValueChanged;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;

  @override
  State<SegmentedControl<T>> createState() => _SegmentedControlState<T>();
}

final class _SegmentedControlState<T extends CustomStringConvertible>
    extends State<SegmentedControl<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.values.length; i++) ...[
          ValueButton(
            title: widget.values[i].toCustomString(),
            onPressed: () {
              setState(() {
                _currentValue = widget.values[i];
                widget.onValueChanged(_currentValue);
              });
            },
            selectedColor: widget.selectedColor,
            unSelectedColor: widget.unSelectedColor,
            selectedBackgroundColor: widget.selectedBackgroundColor,
            unSelectedBackgroundColor: widget.unSelectedBackgroundColor,
            isSelected: widget.values[i] == _currentValue,
          ),
          if (i < widget.values.length - 1) const Gap(4.0),
        ],
      ],
    );
  }
}

final class ValueButton extends StatelessWidget {
  const ValueButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.selectedBackgroundColor,
    required this.unSelectedBackgroundColor,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onPressed;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        foregroundColor: isSelected ? selectedColor : unSelectedColor,
        backgroundColor:
            isSelected ? selectedBackgroundColor : unSelectedBackgroundColor,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
