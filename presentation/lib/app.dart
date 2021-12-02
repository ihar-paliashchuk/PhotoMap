library presentation;

import 'package:core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:presentation/di/app_module.dart';
import 'package:presentation/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_event.dart';

class App extends StatelessWidget {

  final usecases = AppModule.create();
  
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosBloc>(
      create: (_) => PhotosBloc(usecases[0], usecases[1], usecases[2])
        ..add(const GetPhotosEvent(userId: userId)),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: appName),
      ),
    );
  }
}
