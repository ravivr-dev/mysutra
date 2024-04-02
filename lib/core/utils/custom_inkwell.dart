import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  final Widget? child;
  final bool removeSplash;

  const CustomInkwell({
    super.key,
    this.child,
    this.removeSplash = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: removeSplash ? NoSplash.splashFactory : null,
      overlayColor:
          removeSplash ? MaterialStateProperty.all(Colors.transparent) : null,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
