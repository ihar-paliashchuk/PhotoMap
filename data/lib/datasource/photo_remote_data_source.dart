import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PhotoDataSource {
  Future<DocumentSnapshot> getAllPhotos(String userId);
}


class PhotoRemoteDataSource implements PhotoDataSource {
  final FirebaseFirestore firestore;

  PhotoRemoteDataSource({required this.firestore});

  @override
  Future<DocumentSnapshot> getAllPhotos(String userId) {
    try {
      return firestore.collection('photosData').doc(userId).get();
    } on Exception {
      throw PhotosCollectionException();
    }
  }
}

class PhotosCollectionException implements Exception {}
