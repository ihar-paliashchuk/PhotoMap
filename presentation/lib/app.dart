library presentation;

import 'package:domain/usecase/upload_photos_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/datasource/photo_remote_data_source.dart';
import 'package:data/repository/photo_repository_impl.dart';
import 'package:domain/usecase/get_photos_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_event.dart';
import 'package:firebase_storage/firebase_storage.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = PhotoRepositoryImpl(PhotoRemoteDataSource(
        firestore: FirebaseFirestore.instance,
        storage: FirebaseStorage.instance));
    return BlocProvider<PhotosBloc>(
      create: (_) => PhotosBloc(
        GetAllPhotosUseCase(repository),
        UploadPhotosUseCase(repository),
      )..add(const GetPhotosEvent(userId: "1234")),
      child: MaterialApp(
        title: 'Photo Map',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
