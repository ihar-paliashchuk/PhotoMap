import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddPhotoPage> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhotoPage> {
  TextEditingController descriptionController = TextEditingController();

  final List<XFile> _photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Select Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildPhotoInfo(),
              SizedBox(height: 150, child: _buildPhotoList()),
            ]),
      ),
    );
  }

  List<Widget> _buildPhotoInfo() {
    return [
      _buildChoosePhoto(),
      _buildDescription(),
      _buildSelectLocation(),
    ];
  }

  Widget _buildChoosePhoto() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: IconButton(
        icon: const Icon(Icons.add_a_photo_rounded),
        onPressed: () {
          _showGalleryOrCameraBottomSheet(context);
        },
      ),
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      controller: descriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Description is empty';
        }
        return null;
      },
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Description'),
    );
  }

  Widget _buildSelectLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('Select location'),
        ),
      ),
    );
  }

  Widget _buildPhotoList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _photos.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildPhotoItem(index);
      },
    );
  }

  Widget _buildPhotoItem(int index) {
    if (kIsWeb) {
      return Card(
          child: Image.network(
        _photos[index].path,
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      ));
    } else {
      return Card(
          child: Image.file(
        File(_photos[index].path),
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      ));
    }
  }

  _selectImage(ImageSource imageSource) async {
    XFile? image =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 50);

    if (image != null) {
      setState(() {
        _photos.add(image);
      });
    }
  }

  void _showGalleryOrCameraBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext buildCondext) {
          final items = <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _selectImage(ImageSource.gallery);
                  Navigator.of(buildCondext).pop();
                })
          ];
          if (!kIsWeb) {
            items.add(
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _selectImage(ImageSource.camera);
                  Navigator.of(buildCondext).pop();
                },
              ),
            );
          }
          return SafeArea(
            child: Wrap(children: items),
          );
        });
  }
}
