import 'package:domain/entity/photos.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosLoading extends PhotosState {}

class PhotosSuccess extends PhotosState {
  final List<Photos> photos;

  const PhotosSuccess({required this.photos});
}

class PhotosError extends PhotosState {}

class PhotoPressedState extends PhotosState {
  final Photos photos;

  const PhotoPressedState({required this.photos});
}
