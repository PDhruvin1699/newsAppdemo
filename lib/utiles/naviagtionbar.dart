import 'package:flutter/material.dart';

class YourBottomNavigationBarWidget extends StatelessWidget {
  final double textSize;
  final ValueChanged<double> onSliderChanged;

  YourBottomNavigationBarWidget({
    required this.textSize,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Column(
        children: [
          Slider(
            value: textSize,
            min: 10.0,
            max: 30.0,
            onChanged: onSliderChanged,
          ),
        ],
      ),
    );
  }
}