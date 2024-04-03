import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';

class SelectAccountScreen extends StatelessWidget {
  const SelectAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDeco.screenTopHandler,
        ],
      ),
    );
  }
}
