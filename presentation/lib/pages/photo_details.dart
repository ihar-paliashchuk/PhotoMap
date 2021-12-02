import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PhotoDetailsPage extends StatelessWidget {
  final String photoUrl;
  final String description;

  const PhotoDetailsPage({
    Key? key,
    required this.photoUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Image.network(
          photoUrl,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            child: Text(
              description,
              style: const TextStyle(color: Colors.white),
            ),
            padding: const EdgeInsets.all(30.0),
          ),
        ),
      ],
    );
  }
}
