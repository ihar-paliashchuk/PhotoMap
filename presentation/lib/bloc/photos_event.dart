import 'package:domain/entity/upload_photos_request.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class GetPhotosEvent extends PhotoEvent {
  final String userId;

  const GetPhotosEvent({required this.userId});
}

class GetPhotosByLocationEvent extends PhotoEvent {
  final String userId;
  final String latitude;
  final String longitude;

  const GetPhotosByLocationEvent({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });
}

class UploadPhotosEvent extends PhotoEvent {
  final UploadPhotosRequest request;

  const UploadPhotosEvent({required this.request});
}

