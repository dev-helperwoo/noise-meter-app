import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/controller/controller_detect.dart';
import 'package:flutter_detect_decibel/main.dart';
import 'package:get/get.dart';

/// 소음 오차범위 조작
class ControlDecibelError extends StatelessWidget {
  final _detectController = Get.find<DetectController>();


  @override
  Widget build(BuildContext context) {
    late Timer decrease;
    late Timer increase;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: deviceSize.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: InkResponse(
                child: Icon(Icons.remove, color: Colors.white),
                onTap: () => _detectController.setDecibelError(-1.0),
              ),
              onLongPressStart: (_) => decrease = Timer.periodic(const Duration(milliseconds: 20), (_) {
                _detectController.setDecibelError(-1.0);
              }),
              onLongPressEnd: (_) => decrease.cancel(),
            ),
            const SizedBox(width: 20.0),
            Obx(
              () => Text(
                '${_detectController.decibelError} dB',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              child: InkResponse(
                child: Icon(Icons.add, color: Colors.white),
                onTap: () => _detectController.setDecibelError(1.0),
              ),
              onLongPressStart: (_) => increase = Timer.periodic(const Duration(milliseconds: 20), (_) {
                _detectController.setDecibelError(1.0);
              }),
              onLongPressEnd: (_) => increase.cancel(),
            ),
          ],
        ),
      ),
    );
  }
}
