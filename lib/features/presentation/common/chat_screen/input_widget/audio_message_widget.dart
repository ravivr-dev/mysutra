import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AudioMessageWidget extends StatefulWidget {
  final types.User user;
  final types.AudioMessage audioMessage;
  const AudioMessageWidget(
      {super.key,
      required this.audioMessage,
      required this.user});

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          component.assetImage(path: Assets.iconsIcPlay),
          component.spacer(width: 16),
          component.assetImage(path: Assets.iconsAudio),
          component.spacer(width: 16),
          component.text('16 s',
              style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.white, height: 13, fontSize: 13))
        ],
      ),
    );
  }
}
