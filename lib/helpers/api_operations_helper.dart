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
}
