import 'package:json_annotation/json_annotation.dart';

part "video_information_model.g.dart";

@JsonSerializable(nullable: false)
class VideoInformationModel {
  // {"availableResolutions":[240,360,480],"id":"atzs5boqgjh61","title":"One of the best bloopers I've ever seen! : DunderMifflin","baseDownloadUrl":"https://v.redd.it/atzs5boqgjh61","thumbnailUrl":"https://b.thumbs.redditmedia.com/flhfX_C-ExkSvo5CL7wFiY1DpueQ_TFwfDZYo795fNY.jpg","mediaType":0}

  @JsonKey(name: 'id')
  final String Id;

  @JsonKey(name: 'title')
  final String Title;

  @JsonKey(name: 'baseDownloadUrl')
  final String BaseDownloadUrl;

  @JsonKey(name: 'thumbnailUrl')
  final String ThumbnailUrl;

  @JsonKey(name: 'mediaType')
  final int MediaType;

  @JsonKey(name: 'availableResolutions')
  final List<int> AvailableResolutions;

  static _listResFromJson(dynamic str){
    str.substring(1, str.length-1);
    List<String> split = str.split(',');
    List<int> result = new List();
    for(int i = 0; i < split.length; i++){
      result.add(int.parse(split[i]));
    }
    return result;
  }

  static _listResToJson(List<int> resolutions){
    String result = '['+resolutions.join(",")+"]";
    return result;
  }

  VideoInformationModel({this.Id, this.Title, this.BaseDownloadUrl, this.ThumbnailUrl, this.MediaType, this.AvailableResolutions});

  factory VideoInformationModel.fromJson(Map<String, dynamic> json) => _$VideoInformationModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoInformationModelToJson(this);
}
