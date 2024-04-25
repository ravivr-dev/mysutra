import 'dart:io';

class MediaEntity {
  final File? file;
  final String fileName;
  File? thumbnailImage;
  String filePath;
  String? fileDirPath;
  String? fileUrlPath;
  final String fileSize;
  final String fileType;
  final int? userId;
  final String? verificationType;
  final String? mediaType;
  final String? comment;
  final double? fileHeight;
  final double? fileWidth;
  final int? duration;
  final int? id;

  MediaEntity({
    this.file,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.fileType,
    this.fileUrlPath,
    this.fileDirPath,
    this.thumbnailImage,
    this.userId,
    this.verificationType,
    this.mediaType,
    this.comment,
    this.fileHeight,
    this.fileWidth,
    this.duration,
    this.id,
  });

  @override
  String toString() {
    return 'MediaEntity{file: $file, fileName: $fileName, thumbnailImage: $thumbnailImage, filePath: $filePath, fileSize: $fileSize, fileType: $fileType, userId: $userId, verificationType: $verificationType, mediaType: $mediaType, comment: $comment, fileHeight: $fileHeight, fileWidth: $fileWidth}';
  }
}
