import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/model/model_hands.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:provider/provider.dart';

/// 소음측량 바늘
class NoiseHands extends StatefulWidget {
  const NoiseHands({Key? key}) : super(key: key);

  @override
  _NoiseHandsState createState() => _NoiseHandsState();
}

class _NoiseHandsState extends State<NoiseHands> with SingleTickerProviderStateMixin {
  late AnimationController _control;

  @override
  void initState() {
    _control = AnimationController(vsync: this, duration: Duration(milliseconds: 100))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _control.reset();
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetectRepository>(builder: (_, repository, __) {
      final preValue = min(max(repository.getPreDecibel, 0), 100) - 50;
      final nowValue = min(max(repository.getNowDecibel, 0), 100) - 50;
      final begin = 0.5 * (130 / 180) / 50 * preValue;
      final end = 0.5 * (130 / 180) / 50 * nowValue;

      _control.forward();

      return Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              RotationTransition(
                turns: Tween(begin: begin, end: end).animate(_control),
                child: CustomPaint(
                  painter: HandsPainter(
                    value: 0.0,
                    start: 0,
                    end: 100,
                    color: ColorConst.orange,
                  ),
                ), // 측정기 바늘
              ),
              Center(
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConst.darkGrey,
                  ),
                ),
              ), // 측정기 중심
            ],
          ),
        ),
      );
    });
  }
}
