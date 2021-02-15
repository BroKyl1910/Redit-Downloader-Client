abstract class ApiHelper {
  Future<void> getMediaInformation();
  Future<void> downloadMedia();
}

class RedditApiHelper implements ApiHelper {
  @override
  Future<void> downloadMedia() {
    // TODO: implement downloadMedia
    throw UnimplementedError();
  }

  @override
  Future<void> getMediaInformation() {
    // TODO: implement getMediaInformation
    throw UnimplementedError();
  }
}
