import 'package:data/model/photos_dto.dart';
import 'package:domain/entity/photos.dart';

class PhotosMapper {
  Photos toPhotos(PhotosDto photos) {
    return Photos(
        id: photos.id,
        description: photos.description,
        latitude: photos.latitude,
        longitude: photos.longitude,
        urls: photos.urls);
  }
}
