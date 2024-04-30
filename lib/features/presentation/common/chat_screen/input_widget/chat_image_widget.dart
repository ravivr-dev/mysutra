import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/src/conditional/conditional.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

import '../../../../../../ailoitte_component_injector.dart';

class ChatImageWidget extends StatefulWidget {
  /// Creates an image message widget based on [types.ImageMessage].
  const ChatImageWidget({
    super.key,
    this.imageHeaders,
    this.imageProviderBuilder,
    required this.user,
    required this.message,
    required this.showUserAvatars,
  });

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// See [Chat.imageProviderBuilder].
  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;

  /// [types.ImageMessage].
  final types.ImageMessage message;

  final types.User user;
  final bool showUserAvatars;

  @override
  State<ChatImageWidget> createState() => _ChatImageWidgetState();
}

class _ChatImageWidgetState extends State<ChatImageWidget> {
  ImageProvider? _image;
  Size _size = Size.zero;
  ImageStream? _stream;

  @override
  void initState() {
    super.initState();
    _image = widget.imageProviderBuilder != null
        ? widget.imageProviderBuilder!(
            uri: widget.message.uri,
            imageHeaders: widget.imageHeaders,
            conditional: Conditional(),
          )
        : Conditional().getProvider(
            widget.message.uri,
            headers: widget.imageHeaders,
          );
    _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);
  }

  void _getImage() {
    final oldImageStream = _stream;
    _stream = _image?.resolve(createLocalImageConfiguration(context));
    if (_stream?.key == oldImageStream?.key) {
      return;
    }
    final listener = ImageStreamListener(_updateImage);
    oldImageStream?.removeListener(listener);
    _stream?.addListener(listener);
  }

  void _updateImage(ImageInfo info, bool _) {
    setState(() {
      _size = Size(
        info.image.width.toDouble(),
        info.image.height.toDouble(),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_size.isEmpty) {
      _getImage();
    }
  }

  @override
  void dispose() {
    _stream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int messageWidth =
        widget.showUserAvatars && widget.message.author.id != widget.user.id
            ? min(double.infinity * 0.72, 440).floor()
            : min(double.infinity * 0.78, 440).floor();

    if (_size.aspectRatio == 0) {
      return Container(
        decoration: BoxDecoration(
          color: widget.user.id == widget.message.author.id
              ? AppColors.color0xFF526371.withOpacity(.7)
              : AppColors.blackColor.withOpacity(.05),
          border: Border.all(
            color: widget.user.id == widget.message.author.id
                ? AppColors.color0xFF526371.withOpacity(.7)
                : AppColors.blackColor.withOpacity(.05),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          2,
          2,
          4,
          2,
        ),
        // color: AppColors.color010101.withOpacity(.05),
        height: _size.height,
        width: _size.width,
      );
    } else if (_size.aspectRatio < 0.1 || _size.aspectRatio > 10) {
      return Container(
        decoration: BoxDecoration(
          color: widget.user.id == widget.message.author.id
              ? AppColors.color0xFF526371.withOpacity(.7)
              : AppColors.blackColor.withOpacity(.05),
          border: Border.all(
            color: widget.user.id == widget.message.author.id
                ? AppColors.color0xFF526371.withOpacity(.7)
                : AppColors.blackColor.withOpacity(.05),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          2,
          2,
          4,
          2,
        ),
        // color: widget.user.id == widget.message.author.id
        //     ? AppColors.color1570EF.withOpacity(.7)
        //     : AppColors.color010101.withOpacity(.05),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              margin: const EdgeInsetsDirectional.fromSTEB(
                16,
                16,
                16,
                16,
              ),
              width: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  fit: BoxFit.cover,
                  image: _image!,
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsetsDirectional.fromSTEB(
                  0,
                  16,
                  20,
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message.name,
                      style: widget.user.id == widget.message.author.id
                          ? theme.publicSansFonts.mediumStyle(
                              fontSize: 16,
                              fontColor: AppColors.white,
                            )
                          : theme.publicSansFonts.mediumStyle(
                              fontSize: 16,
                              fontColor: AppColors.blackColor.withOpacity(.7),
                            ),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        formatBytes(widget.message.size.truncate()),
                        style: widget.user.id == widget.message.author.id
                            ? theme.publicSansFonts.mediumStyle(
                                fontSize: 16,
                                fontColor: AppColors.white,
                              )
                            : theme.publicSansFonts.mediumStyle(
                                fontSize: 16,
                                fontColor: AppColors.blackColor.withOpacity(.7),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: widget.user.id == widget.message.author.id
              ? AppColors.color0xFF526371.withOpacity(.7)
              : AppColors.blackColor.withOpacity(.05),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          6,
          6,
          6,
          6,
        ),
        constraints: BoxConstraints(
          maxHeight: messageWidth.toDouble(),
          minWidth: 170,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: AspectRatio(
            aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
            child: Image(
              fit: BoxFit.contain,
              image: _image!,
            ),
          ),
        ),
      );
    }
  }
}
