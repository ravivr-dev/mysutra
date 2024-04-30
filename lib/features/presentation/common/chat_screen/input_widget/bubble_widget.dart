import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class BubbleWidget extends StatelessWidget {
  final types.Message message;
  final bool nextMessageInGroup;
  final Widget child;
  final types.User user;
  const BubbleWidget(
      {required this.message,
      required this.child,
      required this.nextMessageInGroup,
      required this.user,
      super.key});

  @override
  Widget build(BuildContext context) {
    BubbleRtlAlignment? bubbleRtlAlignment;

    final currentUserIsAuthor = user.id == message.author.id;

    const messageBorderRadius = 24.0;
    final borderRadius = bubbleRtlAlignment == BubbleRtlAlignment.left
        ? BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              !currentUserIsAuthor || nextMessageInGroup
                  ? messageBorderRadius
                  : 0,
            ),
            bottomStart: Radius.circular(
              currentUserIsAuthor || nextMessageInGroup
                  ? messageBorderRadius
                  : 0,
            ),
            topEnd: const Radius.circular(messageBorderRadius),
            topStart: const Radius.circular(messageBorderRadius),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(
              currentUserIsAuthor || nextMessageInGroup
                  ? messageBorderRadius
                  : 0,
            ),
            bottomRight: Radius.circular(
              !currentUserIsAuthor || nextMessageInGroup
                  ? messageBorderRadius
                  : 0,
            ),
            topLeft: const Radius.circular(messageBorderRadius),
            topRight: const Radius.circular(messageBorderRadius),
          );
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: user.id != message.author.id ||
                      message.type == types.MessageType.image
                  ? AppColors.blackF2F7FB
                  : AppColors.primaryColor,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: child,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10),
            child: component.text(
                DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(message.createdAt ?? 0),
                ),
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 10,
                  height: 10,
                  fontColor: AppColors.textColor,
                )),
          ),
        ],
      ),
    );
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }
}
