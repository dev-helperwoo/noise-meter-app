import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/model/model_line.dart';

/// 소음척도
class NoiseLine extends StatelessWidget {
  const NoiseLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        foregroundPainter: LinePainter(
          lineColor: ColorConst.darkGrey,
          completeColor: Colors.transparent,
          startAngle: 140,
          endAngle: 260,
          startPercent: 0.0,
          endPercent: 1.0,
          width: 10.0,
        ),
      ),
    );
  }
}
