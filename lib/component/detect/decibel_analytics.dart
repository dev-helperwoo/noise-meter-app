import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:flutter_detect_decibel/util/util_detect.dart';
import 'package:provider/provider.dart';

/// 데시벨 최소, 평균, 최대 통계
class DecibelAnalytics extends StatefulWidget {
  const DecibelAnalytics({Key? key}) : super(key: key);

  @override
  _DecibelAnalyticsState createState() => _DecibelAnalyticsState();
}

class _DecibelAnalyticsState extends State<DecibelAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetectRepository>(builder: (_, repository, __) {
      return Column(
        children: [
          DefaultTextStyle(
            style: TextStyle(fontSize: 20.0, color: ColorConst.deepSkin, fontWeight: FontWeight.w900),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text('MIN'), Text('AVG'), Text('MAX')],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDecibel('${repository.getMinDecibel}'),
              _buildDecibel('${repository.getAvgDecibel}'),
              _buildDecibel('${repository.getMaxDecibel}'),
            ],
          ),
        ],
      );
    });
  }

  /// 데시벨
  Widget _buildDecibel(String decibel) {
    return Text.rich(
      TextSpan(text: decibel, children: [TextSpan(text: ' dB')]),
      style: TextStyle(fontSize: 20.0, color: getDecibelColor(double.parse(decibel))),
    );
  }
}
