// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoInformationModel _$VideoInformationModelFromJson(
    Map<String, dynamic> json) {
  return VideoInformationModel(
    Id: json['id'] as String,
    Title: json['title'] as String,
    BaseDownloadUrl: json['baseDownloadUrl'] as String,
    ThumbnailUrl: json['thumbnailUrl'] as String,
    MediaType: json['mediaType'] as int,
    AvailableResolutions:
        (json['availableResolutions'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$VideoInformationModelToJson(
        VideoInformationModel instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'title': instance.Title,
      'baseDownloadUrl': instance.BaseDownloadUrl,
      'thumbnailUrl': instance.ThumbnailUrl,
      'mediaType': instance.MediaType,
      'availableResolutions': instance.AvailableResolutions,
    };
