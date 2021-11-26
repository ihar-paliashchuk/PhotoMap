import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return _buildPhotoList();
  }

  Widget _buildPhotoList() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Text('Item $index'),
                ),
              ),
            );
          }),
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

  void _selectImage() {}
}
