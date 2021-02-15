import 'dart:async';

import 'package:reddit_downloader_client/helpers/api_operations_helper.dart';
import 'package:reddit_downloader_client/json_models/video_information_model.dart';
import 'package:rxdart/rxdart.dart';

class VideoInformationBloc{
  final StreamController<bool> _isLoadingController = BehaviorSubject();
  Stream<bool> get isLoading => _isLoadingController.stream;

  Future<void> getVideoInformation(String url) async{
    _isLoadingController.add(true);
    VideoInformationModel videoInformationModel = await ApiOperationsHelper.getVideoInformation(url);
    _isLoadingController.add(false);
  }

  void dispose(){
    this._isLoadingController.close();
  }
}