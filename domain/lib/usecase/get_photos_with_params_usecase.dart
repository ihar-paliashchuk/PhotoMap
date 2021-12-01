import 'package:dartz/dartz.dart';
import 'package:domain/failure.dart';
import 'package:domain/repository/photo_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

class GetPhotosWithParamsUseCase extends UseCase {
  final PhotoRepository repository;

  GetPhotosWithParamsUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.getPhotosByLocation(
      params.userId,
      params.latitude,
      params.longitude,
    );
  }
}

class GetPhotosParams extends Equatable {
  final String userId;
  final String latitude;
  final String longitude;

  const GetPhotosParams(this.userId, this.latitude, this.longitude);

  @override
  List<Object?> get props => [userId, latitude, longitude];
}
