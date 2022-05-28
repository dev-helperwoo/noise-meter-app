import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/component/info/dialog_info.dart';
import 'package:flutter_detect_decibel/const/const_color.dart';
import 'package:flutter_detect_decibel/main.dart';
import 'package:flutter_detect_decibel/util/util_common.dart';

class DetectDrawer extends StatefulWidget {
  const DetectDrawer({Key? key}) : super(key: key);

  @override
  _DetectDrawerState createState() => _DetectDrawerState();
}

class _DetectDrawerState extends State<DetectDrawer> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SizedBox(
      width: _size.width * 0.6,
      child: Drawer(
        child: Container(
          color: ColorConst.grey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: ColorConst.darkGrey,
                leading: const SizedBox(),
                actions: [
                  InkResponse(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // _buildMenuCategory(
                    //   '설정',
                    //   children: [
                    //     _buildMenu('테스트', onTap: () => print('text')),
                    //   ],
                    // ),
                    _buildMenuCategory(
                      'App Guide',
                      onTap: (_) => showInfoDialog(context),
                    ),
                    _buildMenuCategory(
                      'Opensource License',
                      onTap: (_) => showLicensePage(
                        context: context,
                        applicationName: 'Noise Measurement App',
                        applicationIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(getAssetImage('app_logo.png'), width: _size.width * 0.15),
                          ),
                        ),
                        applicationVersion: packageInfo.version,
                      ),
                    ),
                    _buildMenuCategory('App Ver.${packageInfo.version}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 메뉴 카테고리
  Widget _buildMenuCategory(String category, {List<Widget> children = const [], void Function(bool onChanged)? onTap}) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        iconColor: children.isNotEmpty ? Colors.white : Colors.transparent,
        collapsedIconColor: children.isNotEmpty ? Colors.white : Colors.transparent,
        title: Text(
          category,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0, color: Colors.white),
        ),
        children: children,
        onExpansionChanged: onTap,
      ),
    );
  }

  /// 메뉴
  Widget _buildMenu(String menu, {void Function()? onTap}) {
    return ListTile(
      title: Row(
        children: [
          const SizedBox(width: 20.0),
          Text(
            menu,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0, color: Colors.white),
          ),
        ],
      ),
      trailing: onTap != null ? Icon(Icons.arrow_forward_ios, size: 14.0, color: Colors.white) : null,
      onTap: onTap,
    );
  }
}
