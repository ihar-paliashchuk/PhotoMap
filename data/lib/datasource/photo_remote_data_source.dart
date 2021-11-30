import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entity/upload_photos_request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

abstract class PhotoDataSource {
  Future<DocumentSnapshot> getAllPhotos(String userId);
  Future<void> uploadPhotos(UploadPhotosRequest request);
}

class PhotoRemoteDataSource implements PhotoDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  PhotoRemoteDataSource({required this.firestore, required this.storage});

  @override
  Future<DocumentSnapshot> getAllPhotos(String userId) {
    try {
      return firestore.collection('photosData').doc(userId).get();
    } on Exception {
      throw PhotosCollectionException();
    }
  }

  @override
  Future<void> uploadPhotos(UploadPhotosRequest request) async {
    try {
      List<String> urls = [];

      for (var photoFile in request.photos) {
        final reference =
            storage.ref().child("images/image-${UniqueKey().toString()}");
        final uploadTask = await reference.putFile(photoFile);
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        urls.add(downloadUrl);
      }

      request.photosUrls = urls;

      final documentReferencer = firestore
          .collection("photosData")
          .doc('1234')
          .collection('items')
          .doc();

      return await documentReferencer.set(request.toJson());
    } on Exception {
      throw UploadPhotosException();
    }
  }
}

class PhotosCollectionException implements Exception {}

class UploadPhotosException implements Exception {}
