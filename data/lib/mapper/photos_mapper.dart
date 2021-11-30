import 'package:data/dto/photos_dto.dart';
import 'package:domain/entity/photos.dart';

class PhotosMapper {
  static Photos fromDto(PhotosDto photos) {
    return Photos(
        id: photos.id,
        description: photos.description,
        latitude: photos.latitude,
        longitude: photos.longitude,
        photos: photos.photos);
  }
}
