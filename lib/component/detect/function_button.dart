import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/controller/controller_detect.dart';
import 'package:get/get.dart';

/// 소음측정 조작버튼
class DetectControl extends StatelessWidget {
  final _detectController = Get.find<DetectController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return FloatingActionButton(
            backgroundColor: _detectController.isRecording.value ? ColorConst.lightBrown : ColorConst.orange,
            child: _detectController.isRecording.value ? Icon(Icons.pause) : Icon(Icons.play_arrow_rounded),
            tooltip: _detectController.isRecording.value ? '측정종료' : '측정시작',
            onPressed: _detectController.isRecording.value ? _detectController.stop : _detectController.start,
          );
        }),
        const SizedBox(width: 24.0),
        FloatingActionButton(
          backgroundColor: ColorConst.darkGrey,
          child: Icon(Icons.refresh_rounded),
          tooltip: '초기화',
          onPressed: () => _detectController.clear(),
        ),
      ],
    );
  }
}
