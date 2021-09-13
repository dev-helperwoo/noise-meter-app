import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/controller/controller_detect.dart';
import 'package:flutter_detect_decibel/main.dart';
import 'package:flutter_detect_decibel/util/util_detect.dart';
import 'package:get/get.dart';

/// 현재 데시벨 크기
class CurrentDecibel extends StatelessWidget {
  final _detectController = Get.find<DetectController>();

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: deviceSize.width * 0.12),
        child: Obx(() {
          return RichText(
            text: TextSpan(
              text: '${_detectController.getNowDecibel}',
              style: TextStyle(fontSize: 40.0, color: getDecibelColor(_detectController.getNowDecibel)),
              children: [
                TextSpan(text: ' dB', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
