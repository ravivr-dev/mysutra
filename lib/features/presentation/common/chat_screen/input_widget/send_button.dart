import 'package:flutter/material.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          // icon :component.assetImage(path: Assets.iconsSendMessage,) ,
          icon: const Icon(Icons.send),
          onPressed: onPressed,
          padding: padding,
          splashRadius: 24,
          tooltip: "Send Button",
        ),
      );
}
