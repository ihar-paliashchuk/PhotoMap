import 'package:domain/entity/photos.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosLoading extends PhotosState {}

class PhotosUploding extends PhotosState {}

class PhotosSuccess extends PhotosState {
  final List<Photos> photos;

  const PhotosSuccess({required this.photos});

  @override
  List<Object> get props => [photos];
}

class UploadPhotosSuccess extends PhotosState {}

class PhotosEmpty extends PhotosState {}

class PhotosError extends PhotosState {}
