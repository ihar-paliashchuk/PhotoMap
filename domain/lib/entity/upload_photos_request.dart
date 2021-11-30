import 'dart:io';

class UploadPhotosRequest {
  final String id;
  final String description;
  final String latitude;
  final String longitude;
  List<File> photos;
  List<String>? photosUrls;

  UploadPhotosRequest({
    required this.id,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'photoUrls': photosUrls,
    };
  }
}
