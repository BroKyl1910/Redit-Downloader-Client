import 'dart:async';

import 'package:reddit_downloader_client/helpers/api_operations_helper.dart';
import 'package:rxdart/rxdart.dart';

class VideoDownloadBloc {
  final StreamController<bool> _isDownloadingController = BehaviorSubject();
  Stream<bool> get isDownloading => _isDownloadingController.stream;

  Future<void> downloadVideo(String baseUrl, int quality) async {
    _isDownloadingController.add(true);
    await ApiOperationsHelper.downloadVideo(baseUrl, quality);
    _isDownloadingController.add(false);
  }

  void dispose() {
    this._isDownloadingController.close();
  }
}
