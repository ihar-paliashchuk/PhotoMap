import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/datasource/photo_remote_data_source.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoDataSourceModule {
  static PhotoDataSource? _photoDataSource;

  static PhotoDataSource photoDataSource(
    FirebaseFirestore firestore,
    FirebaseStorage storage,
  ) {
    return _photoDataSource ??= PhotoRemoteDataSource(firestore, storage);
  }
}
