import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:flutter_chat_ui/src/widgets/state/inherited_chat_theme.dart'
    as in_theme;
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

/// Renders user's avatar or initials next to a message.
class UserAvatarWidget extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatarWidget({
    super.key,
    required this.author,
    this.bubbleRtlAlignment,
    this.imageHeaders,
    this.onAvatarTap,
  });

  /// Author to show image and name initials from.
  final types.User author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Called when user taps on an avatar.
  final void Function(types.User)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      in_theme.InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: bubbleRtlAlignment == BubbleRtlAlignment.left
              ? const EdgeInsetsDirectional.only(end: 8)
              : const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onAvatarTap?.call(author),
            child: CircleAvatar(
              backgroundColor: hasImage
                  ? in_theme.InheritedChatTheme.of(context)
                      .theme
                      .userAvatarImageBackgroundColor
                  : color,
              backgroundImage: hasImage
                  ? NetworkImage(author.imageUrl!, headers: imageHeaders)
                  : null,
              radius: 16,
              child: !hasImage
                  ? Text(
                      initials,
                      style: in_theme.InheritedChatTheme.of(context)
                          .theme
                          .userAvatarTextStyle,
                    )
                  : null,
            ),
          ),
        ),
        component.spacer(height: 2),
        component.text("${author.firstName}${author.lastName}",
            style: theme.publicSansFonts.semiBoldStyle(
                fontColor: AppColors.black000E08, fontSize: 14, height: 14))
      ],
    );
  }

  /// Returns user avatar and name color based on the ID.
  Color getUserAvatarNameColor(types.User user, List<Color> colors) =>
      colors[user.id.hashCode % colors.length];

  /// Returns user initials (can have only first letter of firstName/lastName or both).
  String getUserInitials(types.User user) {
    var initials = '';

    if ((user.firstName ?? '').isNotEmpty) {
      initials += user.firstName![0].toUpperCase();
    }

    if ((user.lastName ?? '').isNotEmpty) {
      initials += user.lastName![0].toUpperCase();
    }

    return initials.trim();
  }

  /// Returns user name as joined firstName and lastName.
  String getUserName(types.User user) =>
      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
}
