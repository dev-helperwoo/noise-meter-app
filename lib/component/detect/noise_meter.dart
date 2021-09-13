import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/component/detect/current_decibel.dart';
import 'package:flutter_detect_decibel/component/detect/painter_noise_hands.dart';
import 'package:flutter_detect_decibel/component/detect/painter_noise_line.dart';
import 'package:flutter_detect_decibel/component/detect/set_decibel_error.dart';
import 'package:flutter_detect_decibel/main.dart';

/// 소음 측정기
class NoiseLevel extends StatelessWidget {
  const NoiseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: deviceSize.width * 0.7,
        width: deviceSize.width * 0.7,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            NoiseLine(), // 측정기 라인
            NoiseHands(), // 측정기 바늘
            CurrentDecibel(), // 현재 데시벨 크기
            ControlDecibelError(), // 데시벨 오차설정
          ],
        ),
      ),
    );
  }
}
