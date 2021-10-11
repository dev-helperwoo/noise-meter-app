import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noise_meter/noise_meter.dart';

class DetectController extends GetxController {
  /// 녹음여부
  RxBool isRecording = false.obs;

  /// 소음데이터
  StreamSubscription<NoiseReading>? noiseSubscription;

  /// 소음객체
  late NoiseMeter noiseMeter;

  /// 이전 데시벨
  RxDouble preDecibel = 0.0.obs;

  /// 최대 데시벨
  RxDouble maxDecibel = 0.0.obs;

  /// 데시벨 오차
  RxDouble decibelError = 0.0.obs;

  /// 데시벨 목록
  RxList<double> decibelList = <double>[].obs;

  @override
  void onInit() {
    noiseMeter = new NoiseMeter(onError);
    start();
    super.onInit();
  }

  @override
  void dispose() {
    noiseSubscription?.cancel();
    super.dispose();
  }

  /// 최대 데시벨
  double get getMaxDecibel {
    double maxDecibel = 0.0;
    if (decibelList.length < 2) return maxDecibel;
    maxDecibel = (decibelList.reduce((c, n) => c > n ? c : n));
    maxDecibel += decibelError.value;
    return (maxDecibel * 10).round() / 10;
  }

  /// 평균 데시벨
  double get getAvgDecibel {
    double avgDecibel = 0.0;
    if (decibelList.length < 2) return avgDecibel;
    final sum = decibelList.fold<double>(0, (c, n) => c + n);
    if (sum > 0) avgDecibel = (sum / decibelList.length);
    avgDecibel += decibelError.value;
    return (avgDecibel * 10).round() / 10;
  }

  /// 최소 데시벨
  double get getMinDecibel {
    double minDecibel = 0.0;
    if (decibelList.length < 2) return minDecibel;
    minDecibel = (decibelList.reduce((c, n) => c < n ? c : n));
    minDecibel += decibelError.value;
    return (minDecibel * 10).round() / 10;
  }

  /// 이전 데시벨
  double get getPreDecibel {
    return min(100, max(0, ((preDecibel.value + decibelError.value) * 10).round() / 10));
  }

  /// 현재 데시벨
  double get getNowDecibel {
    return min(100, max(0, ((maxDecibel.value + decibelError.value) * 10).round() / 10));
  }

  /// 데시벨 오차 설정
  void setDecibelError(double error) {
    decibelError.value += error;
  }

  /// 데이터 수신
  void onData(NoiseReading noiseReading) {
    if (!isRecording.value) {
      isRecording.value = true;
    } else {
      preDecibel.value = maxDecibel.value;
      maxDecibel.value = noiseReading.maxDecibel;
      if (maxDecibel.value.isInfinite || maxDecibel.value.isNaN) {
        maxDecibel.value = 0.0;
      }
      if (maxDecibel.value != 0.0) {
        decibelList.add(maxDecibel.value);
      }
      print('데이터 수신: ${noiseReading.toString()}');
    }
  }

  /// 에러발생
  void onError(PlatformException e) {
    print('객체생성 Error: $e');
    this.isRecording.value = false;
  }

  /// 녹음 시작
  void start() {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      noiseSubscription = noiseMeter.noiseStream.listen(onData);
    } catch (e) {
      print('녹음시작 Error: $e');
    }
  }

  /// 녹음 중지
  void stop() {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      // 녹음 종료
      isRecording.value = false;
    } catch (e) {
      print('녹음중지 Error: $e');
    }
  }

  /// 측정 초기화
  void clear() {
    preDecibel.value = 0.0;
    maxDecibel.value = 0.0;
    decibelList.clear();
  }
}