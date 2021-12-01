import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_state.dart';
import 'package:presentation/pages/add_photo.dart';

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
      if (state is PhotosLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is PhotosError) {
        return const Center(child: Text("Error"));
      }
      if (state is PhotosSuccess) {
        return _buildPhotoList(state.photos
            .map((e) => e.photos)
            .expand((element) => element)
            .toList());
      }
      return _buildPhotoList(List.empty());
    });
  }

  Widget _buildPhotoList(List<String> photos) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) => _buildPhotoItem(photos[index]),
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

  Widget _buildPhotoItem(String photoUrl) {
    return Card(
      child: Image.network(
        photoUrl,
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  void _selectImage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPhotoPage()));
  }
}
