import 'package:dartz/dartz.dart';
import 'package:domain/failure.dart';
import 'package:domain/repository/photo_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

class GetAllPhotosUseCase extends UseCase {
  final PhotoRepository repository;

  GetAllPhotosUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.getAllPhotos(params.userId);
  }
}

class GetAllPhotosParams extends Equatable {
  final String userId;

  const GetAllPhotosParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
