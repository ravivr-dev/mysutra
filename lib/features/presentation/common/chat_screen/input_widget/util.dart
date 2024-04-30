import 'dart:ui';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class Util{
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