import 'package:domain/entity/photos.dart';

class PhotosDto extends Photos {
  const PhotosDto({
    required String id,
    required String description,
    required String latitude,
    required String longitude,
    required List<String> urls,
  }) : super(
            id: id,
            description: description,
            latitude: latitude,
            longitude: longitude,
            urls: urls);

  factory PhotosDto.fromJson(Map<String, dynamic> json) {
    return PhotosDto(
      id: json['id'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      urls: List<String>.from(json['photoUrls']),
    );
  }
}
