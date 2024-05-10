import 'package:my_sutra/core/utils/constants.dart';

class VideoRoomResponseModel {
  final String message;
  final String videoSdkRoomId;
  final String videoSdkToken;

  VideoRoomResponseModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        videoSdkRoomId = json[Constants.videoSdkRoomId],
        videoSdkToken = json[Constants.videoSdkToken];
}
