import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/controller/controller_detect.dart';
import 'package:flutter_detect_decibel/util/util_detect.dart';
import 'package:get/get.dart';

/// 데시벨 최소, 평균, 최대 통계
class DecibelAnalytics extends StatelessWidget {
  final _detectController = Get.find<DetectController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextStyle(
          style: TextStyle(fontSize: 20.0, color: ColorConst.deepSkin, fontWeight: FontWeight.w900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('MIN'), Text('AVG'), Text('MAX')],
          ),
        ),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDecibel('${_detectController.getMinDecibel}'),
              _buildDecibel('${_detectController.getAvgDecibel}'),
              _buildDecibel('${_detectController.getMaxDecibel}'),
            ],
          );
        }),
      ],
    );
  }

  /// 데시벨
  Widget _buildDecibel(String decibel) {
    return RichText(
      text: TextSpan(
        text: decibel,
        style: TextStyle(fontSize: 20.0, color: getDecibelColor(double.parse(decibel))),
        children: [TextSpan(text: ' dB')],
      ),
    );
  }
}
