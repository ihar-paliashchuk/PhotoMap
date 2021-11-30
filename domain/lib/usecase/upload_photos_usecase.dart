import 'package:dartz/dartz.dart';
import 'package:domain/entity/upload_photos_request.dart';
import 'package:domain/failure.dart';
import 'package:domain/repository/photo_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

class UploadPhotosUseCase extends UseCase {
  final PhotoRepository repository;

  UploadPhotosUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.uploadPhotos(params);
  }
}

class UploadPhotosUseCaseParams extends Equatable {
  final UploadPhotosRequest request;

  const UploadPhotosUseCaseParams({required this.request});

  @override
  List<Object?> get props => [request];
}
