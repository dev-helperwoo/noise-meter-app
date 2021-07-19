import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:provider/provider.dart';

/// 기능 버튼
class FunctionButton extends StatefulWidget {
  const FunctionButton({Key? key}) : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetectRepository>(builder: (_, repository, __) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: repository.isRecording ? ColorConst.lightBrown : ColorConst.orange,
            child: repository.isRecording ? Icon(Icons.pause) : Icon(Icons.play_arrow_rounded),
            tooltip: repository.isRecording ? '측정종료' : '측정시작',
            onPressed: repository.isRecording ? repository.stop : repository.start,
          ),
          const SizedBox(width: 24.0),
          FloatingActionButton(
            backgroundColor: ColorConst.darkGrey,
            child: Icon(Icons.refresh_rounded),
            tooltip: '초기화',
            onPressed: () => repository.clear(),
          ),
        ],
      );
    });
  }
}
