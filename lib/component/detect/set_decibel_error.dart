import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:provider/provider.dart';

/// 데시벨 오차범위 설정
class SetDecibelError extends StatefulWidget {
  const SetDecibelError({Key? key}) : super(key: key);

  @override
  _SetDecibelErrorState createState() => _SetDecibelErrorState();
}

class _SetDecibelErrorState extends State<SetDecibelError> {
  late Timer _decrease;
  late Timer _increase;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Consumer<DetectRepository>(builder: (_, repository, __) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: _size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: InkResponse(
                  child: Icon(Icons.remove, color: Colors.white),
                  onTap: () => repository.setDecibelError(-1.0),
                ),
                onLongPressStart: (_) => _decrease = Timer.periodic(const Duration(milliseconds: 200), (_) {
                  repository.setDecibelError(-1.0);
                }),
                onLongPressEnd: (_) => _decrease.cancel(),
              ),
              const SizedBox(width: 20.0),
              Text(
                '${repository.decibelError} dB',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              const SizedBox(width: 20.0),
              GestureDetector(
                child: InkResponse(
                  child: Icon(Icons.add, color: Colors.white),
                  onTap: () => repository.setDecibelError(1.0),
                ),
                onLongPressStart: (_) => _increase = Timer.periodic(const Duration(milliseconds: 200), (_) {
                  repository.setDecibelError(1.0);
                }),
                onLongPressEnd: (_) => _increase.cancel(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
