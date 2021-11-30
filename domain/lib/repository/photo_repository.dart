import 'package:dartz/dartz.dart';
import 'package:domain/entity/photos.dart';
import 'package:domain/entity/upload_photos_request.dart';
import 'package:domain/failure.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<Photos>>> getAllPhotos(String userId);

  Future<Either<Failure, List<Photos>>> getPhotosByLocation(
    String userId,
    String latitude,
    String longitude,
  );

  Future<Either<Failure, void>> uploadPhotos(
    UploadPhotosRequest requestParams,
  );
}
