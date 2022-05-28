import 'package:flutter/material.dart';
import 'package:flutter_detect_decibel/main.dart';

/// 키보드 on/off 감지
class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget child;

  const KeyboardVisibilityBuilder({Key? key, required this.child}) : super(key: key);

  @override
  _KeyboardVisibilityBuilderState createState() => _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;

    if (newValue != globalIsKeyboardShow.value) {
      globalIsKeyboardShow.value = newValue;

      // 키보드 off 경우 포커스 아웃
      if (!globalIsKeyboardShow.value) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      }, // 화면터치 시 키보드 off
      child: widget.child,
    );
  }
}
