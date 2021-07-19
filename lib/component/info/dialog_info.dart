import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';

/// 정보 다이얼로그
Future<void> showInfoDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          '소음측정기 사용법',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '조용한 곳에서 ',
            style: TextStyle(color: Colors.black, height: 1.8),
            children: [
              TextSpan(text: '20dB ~ 25dB', style: TextStyle(color: ColorConst.orange)),
              TextSpan(text: '로'),
              TextSpan(text: '\n측정기 하단 -, + 버튼을 활용하여'),
              TextSpan(text: '\n보정 후 사용하시기를 추천합니다.'),
              TextSpan(text: '\n(꾹 누를경우 연속으로 설정됩니다.)', style: TextStyle(color: ColorConst.orange)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => ColorConst.orange.withOpacity(0.3)),
            ),
            child: Text(
              'Close',
              style: TextStyle(color: ColorConst.orange),
            ),
          ),
        ],
      );
    },
  );
}
