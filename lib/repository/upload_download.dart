import 'package:flutter/foundation.dart';

//import '' if (dart.library.html) 'dart:html' as web;
import 'dart:io';
import 'dart:typed_data';
import 'package:anuvad/constants/file_state.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class UploadDownloadFile {
  final _baseUrl = 'https://anuvad.herokuapp.com';
  Dio _dio = Dio();
  UploadDownloadFile() {
    _dio.options.baseUrl = _baseUrl;
  }

  Future<FileState> uploadFile(String fileName, Uint8List file) async {
    FormData formData = FormData.fromMap(
        {'file': MultipartFile.fromBytes(file, filename: fileName)});
    var response = await _dio.post('/upload', data: formData);
    print('response ${response.statusCode}');
    return response.statusCode == 200 ? FileState.processsing : FileState.error;
  }

  Future<FileState> downloadFile(String fileName) async {
    var fileNameWithoutExtension = fileName.substring(0, fileName.length - 4);
    Response response;
    try {
      response = await _dio.get(
        "/convert",
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      if (kIsWeb) {
        // print("Executing Web");
        // web.AnchorElement()
        //   ..href = "${Uri.dataFromBytes(response.data, mimeType: 'video/mp4')}"
        //   ..download = "Translated-$fileNameWithoutExtension.mp4"
        //   ..style.display = 'none'
        //   ..click();
        // print("Download Successful !");
        // return FileState.downloaded;
      }
      print(response.headers);
      Directory appDocDir = await DownloadsPathProvider.downloadsDirectory;
      print(appDocDir.path);
      File file =
          File("${appDocDir.path}/Translated-$fileNameWithoutExtension.mp4");
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      return FileState.downloaded;
    } catch (e) {
      print(e);
      return FileState.error;
    }
  }
}
