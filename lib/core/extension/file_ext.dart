// ignore_for_file: unnecessary_string_escapes

import 'dart:io';
import 'package:my_sutra/core/extension/string_literal.dart';

extension FileExt on File {
  // Future<(int, int)> get mediaSize async {
  //   var decodedImage = await decodeImageFromList(readAsBytesSync());
  //   return (decodedImage.width, decodedImage.height);
  // }
  // Future<PostMediaArgs> get mediaSize async {
  //   var decode =  await decodeImageFromList(readAsBytesSync());
  //     return PostMediaArgs(
  //       fileSize: getFileSize()~/1,
  //       fileHeight: decode.height,
  //       fileWidth: decode.width,
  //     );
  // }

  String get fileNameTimeStamp {
    return DateTime.now().toString().formatDate(dateFormat: "yyyyMMdd_hhmmss");
  }

  String fileName(String type) {
    return type.isEmpty ? fileNameTimeStamp : "$type\_$fileNameTimeStamp.$type";
  }

  double getFileSize() {
    final int sizeInBytes = lengthSync();
    final double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

// String thumbnail(){
//   Uri videoUri = data.getData();
//   String selectedPathVideo="";
//   selectedPathVideo = ImageFilePath.getPath(getApplicationContext(), videoUri);
//   Log.i("Image File Path", ""+selectedPathVideo);
//
//   try {
//     Bitmap thumb = ThumbnailUtils.createVideoThumbnail(selectedPathVideo, MediaStore.Video.Thumbnails.MICRO_KIND);
//
//
//     imgFarmerVideo.setImageBitmap(thumb);
//
//   } catch (Exception e) {
//   e.printStackTrace();
//   }
// }
}
