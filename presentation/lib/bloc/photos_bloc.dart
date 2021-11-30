import 'package:domain/usecase/get_photos_usecase.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_state.dart';
import 'photos_event.dart';

class PhotosBloc extends Bloc<PhotoEvent, PhotosState> {
  final UseCase _getPhotosUseCase;

  PhotosBloc(this._getPhotosUseCase) : super(PhotosLoading());

  @override
  Stream<PhotosState> mapEventToState(PhotoEvent event) async* {
    if (event is GetPhotosEvent) {
      yield PhotosLoading();
      final data =
          await _getPhotosUseCase(GetAllPhotosParams(userId: event.userId));

      yield* data.fold((l) async* {
        yield PhotosError();
      }, (result) async* {
        yield PhotosSuccess(photos: result);
      });
    } else if (event is PhotoPressedEvent) {
      //todo
    }
  }
}
