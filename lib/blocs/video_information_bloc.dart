import 'dart:async';

import 'package:reddit_downloader_client/helpers/api_operations_helper.dart';
import 'package:reddit_downloader_client/json_models/video_information_model.dart';
import 'package:rxdart/rxdart.dart';

class VideoInformationBloc{
  final StreamController<VideoInformationModel> _videoInformationController = BehaviorSubject();
  Stream<VideoInformationModel> get videoInformation => _videoInformationController.stream;

  Future<void> getVideoInformation(String url) async{
    VideoInformationModel videoInformationModel = await ApiOperationsHelper.getVideoInformation(url);
    _videoInformationController.add(videoInformationModel);
  }

  void dispose(){
    this._videoInformationController.close();
  }
}