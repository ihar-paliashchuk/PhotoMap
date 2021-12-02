import 'package:domain/repository/photo_repository.dart';
import 'package:domain/usecase/get_photos_usecase.dart';
import 'package:domain/usecase/get_photos_with_params_usecase.dart';
import 'package:domain/usecase/upload_photos_usecase.dart';
import 'package:domain/usecase/usecase.dart';

class UseCaseModule {
  static UseCase? _getAllPhotosUseCase;
  static UseCase? _getPhotosWithParamsUseCase;
  static UseCase? _uploadPhotosUseCase;

  static UseCase getAllPhotosUseCase(PhotoRepository repository) {
    return _getAllPhotosUseCase ??= GetAllPhotosUseCase(repository);
  }

  static UseCase getPhotosWithParamsUseCase(PhotoRepository repository) {
    return _getPhotosWithParamsUseCase ??= GetPhotosWithParamsUseCase(repository);
  }

  static UseCase getUploadPhotosUseCase(PhotoRepository repository) {
    return _uploadPhotosUseCase ??= UploadPhotosUseCase(repository);
  }
  
}
