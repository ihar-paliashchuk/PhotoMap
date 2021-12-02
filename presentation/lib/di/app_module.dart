import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/mapper/photos_mapper.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:presentation/di/data_source_module.dart';
import 'package:presentation/di/repository_module.dart';
import 'package:presentation/di/usecase_module.dart';

class AppModule {
  static List<UseCase> create() {
    final repository = RepositoryModule.photoRepository(
        PhotoDataSourceModule.photoDataSource(
          FirebaseFirestore.instance,
          FirebaseStorage.instance,
        ),
        PhotosMapper());
    return [
      UseCaseModule.getAllPhotosUseCase(repository),
      UseCaseModule.getPhotosWithParamsUseCase(repository),
      UseCaseModule.getUploadPhotosUseCase(repository),
    ];
  }
}
