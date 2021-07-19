import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';

class LinePainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double startPercent;
  double endPercent;
  double width;
  int startAngle;
  int endAngle;
  final angle = 2 * pi / 360;

  LinePainter({
    required this.lineColor,
    required this.completeColor,
    required this.startAngle,
    required this.endAngle,
    required this.startPercent,
    required this.endPercent,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 측정기 라인
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    // 메인 측정량
    Paint scale = new Paint()
      ..color = ColorConst.skin
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width + 10;
    // 측정량 텍스트
    TextPainter scaleText(String text) => TextPainter(
          text: TextSpan(text: text, style: TextStyle(color: ColorConst.orange)),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
    // 보조 측정량
    Paint subScale = new Paint()
      ..color = ColorConst.deepSkin
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawArc(
      new Rect.fromCircle(center: center, radius: radius),
      startAngle * angle,
      endAngle * angle,
      false,
      line,
    );

    for (var i = 0; i < 11; i++) {
      final mainStart = (140 + (26 * i));
      final mainNextStart = (140 + (26 * (i + 1)));
      canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius * 0.96),
        mainStart * angle,
        angle,
        false,
        scale,
      );

      TextPainter tp = scaleText('${i * 10}');
      tp.layout();
      tp.paint(
        canvas,
        Offset(
          radius * 1.15 * cos(angle * mainStart) + center.dx - 8,
          radius * 1.15 * sin(angle * mainStart) + center.dy - 10,
        ),
      );

      if (i != 10) {
        for (var j = 1; j < 6; j++) {
          canvas.drawArc(
            new Rect.fromCircle(center: center, radius: radius),
            (mainStart + ((mainNextStart - mainStart) / 5 * j)) * angle,
            angle,
            false,
            subScale,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
