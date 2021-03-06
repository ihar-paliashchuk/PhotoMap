import 'package:domain/entity/photos.dart';
import 'package:domain/usecase/get_photos_usecase.dart';
import 'package:domain/usecase/get_photos_with_params_usecase.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_state.dart';
import 'photos_event.dart';

class PhotosBloc extends Bloc<PhotoEvent, PhotosState> {
  final UseCase _getPhotosUseCase;
  final UseCase _getPhotosByLocationUseCase;
  final UseCase _uploadPhotosUseCase;

  PhotosBloc(
    this._getPhotosUseCase,
    this._getPhotosByLocationUseCase,
    this._uploadPhotosUseCase,
  ) : super(PhotosLoading());

  @override
  Stream<PhotosState> mapEventToState(PhotoEvent event) async* {
    if (event is GetPhotosEvent) {
      yield PhotosLoading();
      final data =
          await _getPhotosUseCase(GetAllPhotosParams(userId: event.userId));

      yield* data.fold((l) async* {
        yield PhotosError();
      }, (result) async* {
        if ((result as List<Photos>).isEmpty) {
          yield PhotosEmpty();
        } else {
          yield PhotosSuccess(photos: result);
        }
      });
    } else if (event is GetPhotosByLocationEvent) {
      yield PhotosLoading();
      final data = await _getPhotosByLocationUseCase(GetPhotosParams(
        event.userId,
        event.latitude,
        event.longitude,
      ));
      yield* data.fold((l) async* {
        yield PhotosError();
      }, (result) async* {
        yield PhotosSuccess(photos: result);
      });
    } else if (event is UploadPhotosEvent) {
      yield PhotosUploding();
      final data = await _uploadPhotosUseCase(event.request);

      yield* data.fold((l) async* {
        yield PhotosError();
      }, (result) async* {
        yield UploadPhotosSuccess();
      });
    }
  }
}
