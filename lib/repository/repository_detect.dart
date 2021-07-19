import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';

class DetectRepository extends ChangeNotifier {
  /// 녹음여부
  bool isRecording = false;

  /// 소음데이터
  StreamSubscription<NoiseReading>? noiseSubscription;

  /// 소음객체
  late NoiseMeter noiseMeter;

  /// 이전 데시벨
  double preDecibel = 0.0;

  /// 최대 데시벨
  double maxDecibel = 0.0;

  /// 데시벨 오차
  double decibelError = 0.0;

  /// 데시벨 목록
  List<double> decibelList = [];

  /// 최대 데시벨
  double get getMaxDecibel {
    double maxDecibel = 0.0;
    if (decibelList.length < 2) return maxDecibel;
    maxDecibel = (decibelList.reduce((c, n) => c > n ? c : n));
    maxDecibel += decibelError;
    return (maxDecibel * 10).round() / 10;
  }

  /// 평균 데시벨
  double get getAvgDecibel {
    double avgDecibel = 0.0;
    if (decibelList.length < 2) return avgDecibel;
    final sum = decibelList.fold<double>(0, (c, n) => c + n);
    if (sum > 0) avgDecibel = (sum / decibelList.length);
    avgDecibel += decibelError;
    return (avgDecibel * 10).round() / 10;
  }

  /// 최소 데시벨
  double get getMinDecibel {
    double minDecibel = 0.0;
    if (decibelList.length < 2) return minDecibel;
    minDecibel = (decibelList.reduce((c, n) => c < n ? c : n));
    minDecibel += decibelError;
    return (minDecibel * 10).round() / 10;
  }

  /// 이전 데시벨
  double get getPreDecibel {
    return min(100, max(0, ((preDecibel + decibelError) * 10).round() / 10));
  }

  /// 현재 데시벨
  double get getNowDecibel {
    return min(100, max(0, ((maxDecibel + decibelError) * 10).round() / 10));
  }

  /// 데시벨 오차 설정
  void setDecibelError(double error) {
    decibelError += error;
    notifyListeners();
  }

  /// 데이터 수신
  void onData(NoiseReading noiseReading) {
    if (!isRecording) {
      isRecording = true;
    } else {
      preDecibel = maxDecibel;
      maxDecibel = noiseReading.maxDecibel;
      if (maxDecibel.isInfinite || maxDecibel.isNaN) maxDecibel = 0.0;
      if (maxDecibel != 0.0) decibelList.add(maxDecibel);
      print('데이터 수신: ${noiseReading.toString()}');
    }
    notifyListeners();
  }

  /// 에러발생
  void onError(PlatformException e) {
    print('객체생성 Error: $e');
    this.isRecording = false;
  }

  /// 녹음 시작
  void start() {
    try {
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
      // 녹음 중인 경우 종료
      if (isRecording) {
        isRecording = false;
        notifyListeners();
      }
    } catch (e) {
      print('녹음중지 Error: $e');
    }
  }

  /// 측정 초기화
  void clear() {
    preDecibel = 0.0;
    maxDecibel = 0.0;
    decibelList.clear();
    notifyListeners();
  }
}
