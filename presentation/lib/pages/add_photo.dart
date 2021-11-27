import 'package:flutter/material.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddPhotoPage> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhotoPage> {
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 200, child: _buildPhotoList()),
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
        onPressed: () {},
      ),
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      controller: descriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
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
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return const Card(
          child: SizedBox(child: Text("20"), height: 200.0),
        );
      },
    );
  }
}
