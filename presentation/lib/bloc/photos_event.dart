import 'package:domain/entity/photos.dart';
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

class UploadPhotosEvent extends PhotoEvent {
  final UploadPhotosRequest request;

  const UploadPhotosEvent({required this.request});
}

class PhotoPressedEvent extends PhotoEvent {
  final Photos photos;

  const PhotoPressedEvent({required this.photos});
}
