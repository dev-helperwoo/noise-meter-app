import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/component/detect/current_decibel.dart';
import 'package:flutter_detect_decibel/component/detect/painter_noise_hands.dart';
import 'package:flutter_detect_decibel/component/detect/painter_noise_line.dart';
import 'package:flutter_detect_decibel/component/detect/set_decibel_error.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:provider/provider.dart';

/// 소음 측정기
class NoiseLevel extends StatefulWidget {
  const NoiseLevel({Key? key}) : super(key: key);

  @override
  _NoiseLevelState createState() => _NoiseLevelState();
}

class _NoiseLevelState extends State<NoiseLevel> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Consumer<DetectRepository>(builder: (_, repository, __) {
      return Center(
        child: Container(
          height: _size.width * 0.7,
          width: _size.width * 0.7,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              NoiseLine(), // 측정기 라인
              NoiseHands(), // 측정기 바늘
              CurrentDecibel(), // 현재 데시벨 크기
              SetDecibelError(), // 데시벨 오차설정
            ],
          ),
        ),
      );
    });
  }
}
