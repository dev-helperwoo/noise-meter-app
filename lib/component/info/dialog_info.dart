import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';

/// 정보 다이얼로그
Future<void> showInfoDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'App Guide',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '정확한 측정을 위해 조용한 곳에서',
            style: TextStyle(color: Colors.black, height: 1.8),
            children: [
              TextSpan(text: '\n- or + 버튼을 활용하여 '),
              TextSpan(
                  text: '20-25(dB)',
                  style: TextStyle(color: ColorConst.orange)),
              TextSpan(text: '로'),
              TextSpan(text: '\n보정후 사용을 권장합니다'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => ColorConst.orange.withOpacity(0.3)),
            ),
            child: Text(
              'CLOSE',
              style: TextStyle(color: ColorConst.orange),
            ),
          ),
        ],
      );
    },
  );
}
