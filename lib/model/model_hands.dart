import 'package:flutter/material.dart';

class HandsPainter extends CustomPainter {
  final Paint minuteHandPaint;
  double value;
  int start;
  int end;
  Color color;

  HandsPainter({
    required this.value,
    required this.start,
    required this.end,
    required this.color,
  }) : minuteHandPaint = new Paint() {
    minuteHandPaint.color = this.color;
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    // final median = this.end / 2;
    // final realValue = min(max(this.value, 0), 100);
    // final angle = (realValue >= median ? realValue - median : -median + realValue) * 2.6;

    canvas.save();
    canvas.translate(radius, radius);
    // canvas.rotate(pi / 180 * angle);

    Path path = new Path();
    path.moveTo(-1.5, -radius - 10.0);
    path.lineTo(-5.0, -radius / 1.8);
    path.lineTo(-2.0, 10.0);
    path.lineTo(2.0, 10.0);
    path.lineTo(5.0, -radius / 1.8);
    path.lineTo(1.5, -radius - 10.0);
    path.close();

    canvas.drawPath(path, minuteHandPaint); // 바늘
    canvas.restore();
  }

  @override
  bool shouldRepaint(HandsPainter oldDelegate) {
    return true;
  }
}
