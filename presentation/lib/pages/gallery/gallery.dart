import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_state.dart';
import 'package:presentation/pages/add_photo.dart';
import 'package:presentation/pages/photo_details.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return _buildState();
  }

  Widget _buildState() {
    return BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
      var stateWidgets = <Widget>[];
      if (state is PhotosLoading) {
        stateWidgets.add(const Center(child: CircularProgressIndicator()));
      }
      if (state is PhotosEmpty) {
        stateWidgets.add(const Center(child: Text("Gallery is still empty")));
      }
      if (state is PhotosError) {
        stateWidgets.add(const Center(child: Text("Error")));
      }
      if (state is PhotosSuccess) {
        return _buildPhotoList(state.photos
            .map((photos) => photos.urls.map((photoUrl) {
                  return [photoUrl, photos.description];
                }))
            .expand((photo) => photo)
            .toList());
      }
      return Stack(children: stateWidgets..add(_buildFabButton()));
    });
  }

  Widget _buildPhotoList(List<List<String>> photos) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) => _buildPhotoItem(
              photoUrl: photos[index][0], description: photos[index][1]),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ),
      _buildFabButton()
    ]);
  }

  Widget _buildFabButton() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0, right: 16.0),
          child: FloatingActionButton(
            onPressed: _selectImage,
            tooltip: 'Select Image',
            child: const Icon(Icons.add),
          ),
        ));
  }

  Widget _buildPhotoItem({
    required String photoUrl,
    required String description,
  }) {
    return Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Card(
          child: Ink.image(
            image: NetworkImage(photoUrl),
            fit: BoxFit.cover,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PhotoDetailsPage(
                      photoUrl: photoUrl, description: description);
                }));
              },
            ),
          ),
        ));
  }

  void _selectImage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPhotoPage()));
  }
}
