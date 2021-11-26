library presentation;

import 'package:flutter/material.dart';

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text('Flutter Demo Home Page'),
    );
  }
}
