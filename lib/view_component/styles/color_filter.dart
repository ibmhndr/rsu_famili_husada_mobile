import 'package:flutter/material.dart';

class CustomColorFilter {
  static ColorFilter brightnessAdjust(double value) {
    if (value >= 0.0) {
      value = value * 255;
    } else {
      value = value * 100;
    }
    List<double> matrix;
    matrix = [
      1,
      0,
      0,
      0,
      value,
      0,
      1,
      0,
      0,
      value,
      0,
      0,
      1,
      0,
      value,
      0,
      0,
      0,
      1,
      0
    ];

    return ColorFilter.matrix(matrix);
  }
}
