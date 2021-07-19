import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/page/detect/page_detect.dart';
import 'package:flutter_detect_decibel/repository/repository_detect.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

late PackageInfo packageInfo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DetectRepository>(create: (context) => DetectRepository()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DetectDecibel',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConst.grey,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: ColorConst.darkGrey,
          iconTheme: IconThemeData(color: Colors.grey),
          brightness: Brightness.dark,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: DetectPage.routeName,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case DetectPage.routeName:
            return MaterialPageRoute(builder: (context) => DetectPage());
        }
      },
    );
  }
}
