import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:data/datasource/photo_remote_data_source.dart';
import 'package:data/model/photos_dto.dart';
import 'package:data/mapper/photos_mapper.dart';
import 'package:domain/entity/photos.dart';
import 'package:domain/entity/upload_photos_request.dart';
import 'package:domain/failure.dart';
import 'package:domain/repository/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource photoDataSource;

  PhotoRepositoryImpl(this.photoDataSource);

  @override
  Future<Either<Failure, List<Photos>>> getAllPhotos(String userId) async {
    try {
      final userDocumentSnapshot = await photoDataSource.getAllPhotos(userId);
      final photosSnapshot =
          await userDocumentSnapshot.reference.collection('items').get();

      return Right(mapPhotos(photosSnapshot.docs));
    } on PhotosCollectionException {
      return Left(PhotosFailure());
    }
  }

  @override
  Future<Either<Failure, List<Photos>>> getPhotosByLocation(
      String userId, String latitude, String longitude) async {
    try {
      final userDocumentSnapshot = await photoDataSource.getAllPhotos(userId);
      final photosSnapshot =
          await userDocumentSnapshot.reference.collection('items').get();

      final result = photosSnapshot.docs.where((value) {
        return value.data()['latitude'] == latitude &&
            value.data()['longitude'] == longitude;
      });

      return Right(mapPhotos(result));
    } on PhotosCollectionException {
      return Left(PhotosFailure());
    }
  }

  List<Photos> mapPhotos(Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> photos) {
    return photos
        .map((e) => PhotosDto.fromJson(e.data()))
        .map((e) => PhotosMapper.fromDto(e))
        .toList();
  }

  @override
  Future<Either<Failure, void>> uploadPhotos(UploadPhotosRequest requestParams) async {
    try {
      final result = await photoDataSource.uploadPhotos(requestParams);
      return Right(result);
    } on UploadPhotosException {
      return Left(UloadPhotosFailure());
    }
  }
}
