import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/controller/controller_detect.dart';
import 'package:flutter_detect_decibel/page/detect/page_detect.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info/package_info.dart';

late PackageInfo packageInfo;
late Size deviceSize;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      scaffoldBackgroundColor: ColorConst.grey,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: ColorConst.darkGrey,
        iconTheme: IconThemeData(color: Colors.grey),
        brightness: Brightness.dark,
      ),
      primarySwatch: Colors.blue,
    );

    final getPages = [
      GetPage(
        name: DetectPage.routeName,
        page: () => DetectPage(),
        binding: BindingsBuilder(() {
          Get.put(DetectController());
        }),
      ),
    ];

    return GetMaterialApp(
      title: '소음측정앱',
      theme: theme,
      initialRoute: DetectPage.routeName,
      getPages: getPages,
      builder: (context, widget) {
        deviceSize = MediaQuery.of(context).size;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    );
  }
}
