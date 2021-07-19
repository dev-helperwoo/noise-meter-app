import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';

/// 데시벨 크기별 텍스트 색상
Color getDecibelColor(double decibel) {
  Color textColor = Colors.white;
  if (decibel >= 70.0) textColor = ColorConst.deepSkin;
  if (decibel >= 50.0 && decibel < 70.0) textColor = ColorConst.skin;
  return textColor;
}
