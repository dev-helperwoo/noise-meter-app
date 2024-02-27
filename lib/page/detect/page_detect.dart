import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/component/detect/decibel_analytics.dart';
import 'package:flutter_detect_decibel/component/detect/drawer.dart';
import 'package:flutter_detect_decibel/component/detect/function_button.dart';
import 'package:flutter_detect_decibel/component/detect/noise_meter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 감지 페이지
class DetectPage extends StatefulWidget {
  static const routeName = '/detect';

  const DetectPage({Key? key}) : super(key: key);

  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  final BannerAd _bottomBanner = BannerAd(
    size: AdSize.banner,
    adUnitId: 'ca-app-pub-1722747288757049/6680714688',
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
    request: AdRequest(),
  );

  @override
  void initState() {
    _bottomBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DetectDrawer(),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                NoiseLevel(), // 데시벨 측정기
                DecibelAnalytics(), // 데시벨 통계(최소, 평균, 최대)
                const SizedBox(height: 40.0),
                DetectControl(), // 기능 버튼
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: AdWidget(ad: _bottomBanner),
                  width: _bottomBanner.size.width.toDouble(),
                  height: _bottomBanner.size.height.toDouble(),
                ), // 배너광고
              ],
            ),
          ],
        ),
      ),
    );
  }
}
