import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/input_widget/input_clear_mode.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/input_widget/send_button_visibility_mode.dart';

import 'attachment_button.dart';
import 'input_text_field_controller.dart';
import 'send_button.dart';

/// A class that represents bottom bar widget with a text field, attachment and
/// send buttons inside. By default hides send button when text field is empty.
class Input extends StatefulWidget {
  /// Creates [Input] widget.
  const Input({
    super.key,
    this.isAttachmentUploading,
    this.onAttachmentPressed,
    required this.onSendPressed,
    this.options = const InputOptions(),
    required this.uploadingMediaNotifier,
    this.shareUrl,
  });

  /// Whether attachment is uploading. Will replace attachment button with a
  /// [CircularProgressIndicator]. Since we don't have libraries for
  /// managing media in dependencies we have no way of knowing if
  /// something is uploading so you need to set this manually.
  final bool? isAttachmentUploading;

  /// See [AttachmentButton.onPressed].
  final VoidCallback? onAttachmentPressed;

  /// Will be called on [SendButton] tap. Has [types.PartialText] which can
  /// be transformed to [types.TextMessage] and added to the messages list.
  final void Function(types.PartialText) onSendPressed;

  /// Customisation options for the [Input].
  final InputOptions options;

  /// Uploading Status Notifier
  final ValueNotifier<bool> uploadingMediaNotifier;

  /// Prefilled Text field with Share url
  final String? shareUrl;

  @override
  State<Input> createState() => _InputState();
}

/// [Input] widget state.
class _InputState extends State<Input> {
  late final _inputFocusNode = FocusNode(
    onKeyEvent: (node, event) {
      if (event.physicalKey == PhysicalKeyboardKey.enter &&
          !HardwareKeyboard.instance.physicalKeysPressed.any(
            (el) => <PhysicalKeyboardKey>{
              PhysicalKeyboardKey.shiftLeft,
              PhysicalKeyboardKey.shiftRight,
            }.contains(el),
          )) {
        if (event is KeyDownEvent) {
          _handleSendPressed();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );

  bool _sendButtonVisible = false;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController =
        widget.options.textEditingController ?? InputTextFieldController();

    if (widget.shareUrl != null && widget.shareUrl!.isNotEmpty) {
      _textController.text = widget.shareUrl!;
    }
    _handleSendButtonVisibilityModeChange();
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options.sendButtonVisibilityMode !=
        oldWidget.options.sendButtonVisibilityMode) {
      _handleSendButtonVisibilityModeChange();
    }
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _inputFocusNode.requestFocus(),
        child: _inputBuilder(),
      );

  void _handleSendButtonVisibilityModeChange() {
    _textController.removeListener(_handleTextControllerChange);

    _sendButtonVisible = true;
  }

  void _handleSendPressed() {
    final trimmedText = _textController.text.trim();
    final partialText = types.PartialText(text: trimmedText);
    widget.onSendPressed(partialText);
    if (widget.options.inputClearMode == InputClearMode.always) {
      _textController.clear();
    }
    /*if (trimmedText != '') {
      final partialText = types.PartialText(text: trimmedText);
      widget.onSendPressed(partialText);
      if (widget.options.inputClearMode == InputClearMode.always) {
        _textController.clear();
      }
    }*/
  }

  void _handleTextControllerChange() {
    setState(() {
      _sendButtonVisible = _textController.text.trim() != '';
    });
  }

  Widget _inputBuilder() {
    final query = MediaQuery.of(context);
    const buttonPadding = EdgeInsets.only(left: 16, right: 16);
    final safeAreaInsets = EdgeInsets.fromLTRB(
      query.padding.left,
      0,
      query.padding.right,
      query.viewInsets.bottom + query.padding.bottom,
    );

    return Focus(
      autofocus: true,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Material(
          color: AppColors.transparent,
          child: Container(
            // decoration:
            //     InheritedChatTheme.of(context).theme.inputContainerDecoration,
            padding: safeAreaInsets,
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    cursorColor: AppColors.blue25.withOpacity(.5),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        suffixIcon: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                buttonPadding.bottom + buttonPadding.top + 24,
                          ),
                          child: Visibility(
                            visible: _sendButtonVisible,
                            child: SendButton(
                              onPressed: _handleSendPressed,
                              padding: buttonPadding,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        isCollapsed: true,
                        hintStyle: theme.publicSansFonts.mediumStyle(
                          fontSize: 16,
                          fontColor: AppColors.textColor,
                        ),
                        hintText: "Type messages..",
                        fillColor: AppColors.fillColor),
                    focusNode: _inputFocusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    onChanged: widget.options.onTextChanged,
                    onTap: widget.options.onTextFieldTap,
                    style: theme.publicSansFonts.mediumStyle(
                        fontSize: 16,
                        fontColor: AppColors.blackColor.withOpacity(.8)),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class InputOptions {
  const InputOptions({
    this.inputClearMode = InputClearMode.always,
    this.onTextChanged,
    this.onTextFieldTap,
    this.sendButtonVisibilityMode = SendButtonVisibilityMode.editing,
    this.textEditingController,
  });

  /// Controls the [Input] clear behavior. Defaults to [InputClearMode.always].
  final InputClearMode inputClearMode;

  /// Will be called whenever the text inside [TextField] changes.
  final void Function(String)? onTextChanged;

  /// Will be called on [TextField] tap.
  final VoidCallback? onTextFieldTap;

  /// Controls the visibility behavior of the [SendButton] based on the
  /// [TextField] state inside the [Input] widget.
  /// Defaults to [SendButtonVisibilityMode.editing].
  final SendButtonVisibilityMode sendButtonVisibilityMode;

  /// Custom [TextEditingController]. If not provided, defaults to the
  /// [InputTextFieldController], which extends [TextEditingController] and has
  /// additional fatures like markdown support. If you want to keep additional
  /// features but still need some methods from the default [TextEditingController],
  /// you can create your own [InputTextFieldController] (imported from this lib)
  /// and pass it here.
  final TextEditingController? textEditingController;
}
