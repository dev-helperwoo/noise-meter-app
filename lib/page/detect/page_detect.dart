import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/component/detect/decibel_analytics.dart';
import 'package:flutter_detect_decibel/component/detect/drawer.dart';
import 'package:flutter_detect_decibel/component/detect/function_button.dart';
import 'package:flutter_detect_decibel/component/detect/noise_meter.dart';
import 'package:flutter_detect_decibel/component/info/dialog_info.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:provider/provider.dart';

/// 감지 페이지
class DetectPage extends StatefulWidget {
  static const routeName = '/detect';

  const DetectPage({Key? key}) : super(key: key);

  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  late DetectRepository _detectRepository;

  @override
  void initState() {
    _detectRepository = Provider.of<DetectRepository>(context, listen: false);
    super.initState();
    _detectRepository.noiseMeter = new NoiseMeter(_detectRepository.onError);
  }

  @override
  void dispose() {
    _detectRepository.noiseSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: _buildBody()),
      drawer: DetectDrawer(),
    );
  }

  /// 바디
  Widget _buildBody() {
    final _size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          right: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkResponse(
              onTap: () => showInfoDialog(context),
              child: Icon(Icons.info_outline_rounded, color: Colors.white, size: 40.0),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            NoiseLevel(), // 데시벨 측정기
            DecibelAnalytics(), // 데시벨 통계(최소, 평균, 최대)
            const SizedBox(height: 40.0),
            FunctionButton(), // 기능 버튼
            const Spacer(),
            // Container(
            //   width: _size.width,
            //   height: _size.height * 0.1,
            //   color: Colors.white,
            // ),
          ],
        ),
      ],
    );
  }
}
