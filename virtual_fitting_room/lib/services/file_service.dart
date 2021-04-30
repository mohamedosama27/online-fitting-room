import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FileService{
  String path;
  FileService({this.path});
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await localPath;
    print(path);
    return File('$path/'+this.path);
  }
  Future<File> writeObject(String object) async {
    final file = await _localFile;
    return file.writeAsString('$object');
  }
  Future<File> writeImage(Uint8List image) async {
    final file = await _localFile;
    return file.writeAsBytes(image);
  }
}