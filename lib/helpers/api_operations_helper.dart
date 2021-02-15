import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:reddit_downloader_client/json_models/video_information_model.dart';

class ApiOperationsHelper {
  static final String API_BASE_URL = "http://192.168.101.114:80/api";
  static final String VIDEO_INFORMATION_ENDPOINT =
      API_BASE_URL + "/VideoDownload/Information";
  static final String VIDEO_DOWNLOAD_ENDPOINT =
      API_BASE_URL + "/VideoDownload/Download";

  static Future<VideoInformationModel> getVideoInformation(String url) async {
    VideoInformationModel model;
    try {
      Dio dio = Dio();
      Map<String, String> params = {
        "url": url,
      };
      // Response response = await dio.post(VIDEO_INFORMATION_ENDPOINT, data: formData);
      Response response =
          await dio.get(VIDEO_INFORMATION_ENDPOINT, queryParameters: params);
      print(response);
      model = VideoInformationModel.fromJson(response.data);
      return model;
    } catch (e) {
      print(e);
      return model;
    }
  }

  static Future downloadVideo(String baseUrl, int quality) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> params = {"baseUrl": baseUrl, "quality": quality};
      Response response =
          await dio.get(VIDEO_DOWNLOAD_ENDPOINT, queryParameters: params);

      Uint8List data = Base64Decoder().convert(response.data);
      File tmpFile = await _writeToFile(data);
      bool result = await GallerySaver.saveVideo(tmpFile.path);
      print(result.toString());
      // print("");
    } catch (e) {
      print(e);
    }
  }

  static Future<File> _writeToFile(Uint8List data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString()+".mp4";
    var filePath =
        tempPath + '/'+fileName;
    return new File(filePath).writeAsBytes(
        buffer.asUint8List());
  }
}
