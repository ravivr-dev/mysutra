import 'package:my_sutra/core/utils/constants.dart';

class GenerateUsernameModel {
  final String message;
  final List<String> userNames;
  final bool userNameAvailable;

  GenerateUsernameModel({
    required this.message,
    required this.userNames,
    required this.userNameAvailable,
  });

// we are getting list<dynamic> from api that's why we are using this map function

  GenerateUsernameModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        userNames = (json[Constants.data] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        userNameAvailable = json[Constants.userNameAvailable];
}
