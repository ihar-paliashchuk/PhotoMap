import 'package:data/datasource/photo_remote_data_source.dart';
import 'package:data/mapper/photos_mapper.dart';
import 'package:data/repository/photo_repository_impl.dart';
import 'package:domain/repository/photo_repository.dart';

class RepositoryModule {
  static PhotoRepository? _photoRepository;

  static PhotoRepository photoRepository(
    PhotoDataSource photoDataSource,
    PhotosMapper mapper,
  ) {
    return _photoRepository ??= PhotoRepositoryImpl(photoDataSource, mapper);
  }
}
