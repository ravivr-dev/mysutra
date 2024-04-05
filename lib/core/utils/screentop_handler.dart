import 'package:flutter/material.dart';

class ScreenTopHandler extends StatelessWidget {
  const ScreenTopHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safeAreaInsets = MediaQuery.of(context).padding;

    if (safeAreaInsets.top < 30) {
      return SizedBox(height: safeAreaInsets.top + 30);
    } else {
      return const SafeArea(child: SizedBox.shrink());
    }
  }
}
