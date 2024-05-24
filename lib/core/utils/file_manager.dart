import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  Directory? _directory;
  static final FileManager _instance = FileManager._();

  FileManager._();

  factory FileManager() => _instance;

  Future<Directory> getApplicationDirectory() async {
    return _directory ??= (await getDownloadsDirectory()) ??
        await getApplicationSupportDirectory();
  }
}
