import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:flutter_detect_decibel/util/util_detect.dart';
import 'package:provider/provider.dart';

/// 현재 데시벨 크기
class CurrentDecibel extends StatefulWidget {
  const CurrentDecibel({Key? key}) : super(key: key);

  @override
  _CurrentDecibelState createState() => _CurrentDecibelState();
}

class _CurrentDecibelState extends State<CurrentDecibel> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Consumer<DetectRepository>(builder: (_, repository, __) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: _size.width * 0.12),
          child: Text.rich(
            TextSpan(
              text: '${repository.getNowDecibel}',
              style: TextStyle(fontSize: 40.0, color: getDecibelColor(repository.getNowDecibel)),
              children: [
                TextSpan(text: ' dB', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
