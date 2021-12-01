import 'dart:io';
import 'package:domain/entity/upload_photos_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_event.dart';
import 'package:presentation/bloc/photos_state.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddPhotoPage> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhotoPage> {
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  final _descriptionGlobalKey = GlobalKey<FormState>();
  final _latitudeGlobalKey = GlobalKey<FormState>();
  final _longitudeGlobalKey = GlobalKey<FormState>();

  final List<XFile> _photos = [];
  var _disableClicks = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _disableClicks,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: const Text("Select Image"),
              actions: _buildAppBarActions()),
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
      Widget stateWidget = const Spacer();
      if (state is PhotosUploding) {
        stateWidget = const Center(child: CircularProgressIndicator());
      } else if (state is PhotosError) {
        stateWidget = const Center(child: Text("Error"));
      } else if (state is UploadPhotosSuccess) {
        BlocProvider.of<PhotosBloc>(context)
            .add(const GetPhotosEvent(userId: '1234'));
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildPhotoInfo(),
              SizedBox(height: 150, child: _buildPhotoList()),
              stateWidget,
            ]),
      );
    });
  }

  _buildAppBarActions() {
    return [
      IconButton(
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          onPressed: () => _validateAndUploadPhotos())
    ];
  }

  List<Widget> _buildPhotoInfo() {
    return [
      _buildChoosePhoto(),
      _buildDescriptionForm(),
      const SizedBox(height: 20),
      _buildLatitudeForm(),
      const SizedBox(height: 20),
      _buildLongitudeForm(),
      const SizedBox(height: 20),
    ];
  }

  Widget _buildChoosePhoto() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: IconButton(
          icon: const Icon(Icons.add_a_photo_rounded),
          onPressed: () => _showGalleryOrCameraBottomSheet(context)),
    );
  }

  Widget _buildDescriptionForm() {
    return Form(
      key: _descriptionGlobalKey,
      child: TextFormField(
          controller: _descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is empty';
            }
            return null;
          },
          decoration: _getInputDecoration('Description')),
    );
  }

  Widget _buildLatitudeForm() {
    return Form(
      key: _latitudeGlobalKey,
      child: TextFormField(
          controller: _latitudeController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Latitude is empty';
            }
            return null;
          },
          decoration: _getInputDecoration('Latitude')),
    );
  }

  Widget _buildLongitudeForm() {
    return Form(
      key: _longitudeGlobalKey,
      child: TextFormField(
          controller: _longitudeController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Longitude is empty';
            }
            return null;
          },
          decoration: _getInputDecoration('Longitude')),
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

  _validateAndUploadPhotos() {
    if (_photos.isEmpty) {
      const snackBar = SnackBar(content: Text("Please add any image"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (_descriptionGlobalKey.currentState!.validate() &&
        _latitudeGlobalKey.currentState!.validate() &&
        _longitudeGlobalKey.currentState!.validate()) {
      _disableClicks = true;

      FocusScope.of(context).unfocus();

      final params = UploadPhotosRequest(
          id: UniqueKey().toString(),
          description: _descriptionController.text,
          latitude: _latitudeController.text,
          longitude: _longitudeController.text,
          photos: _photos.map((e) => File(e.path)).toList());

      BlocProvider.of<PhotosBloc>(context)
          .add(UploadPhotosEvent(request: params));
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

  InputDecoration _getInputDecoration(String laberText) {
    return InputDecoration(
        border: const OutlineInputBorder(), labelText: laberText);
  }
}
