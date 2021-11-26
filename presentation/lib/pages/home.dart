import 'package:flutter/material.dart';
import 'package:presentation/pages/gallery/gallery.dart';
import 'package:presentation/pages/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: _buildTabs(),
        ),
        body: _buildPages(),
      ),
    );
  }

  PreferredSizeWidget _buildTabs() {
    return const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.photo_album)),
        Tab(icon: Icon(Icons.map)),
      ],
    );
  }

  Widget _buildPages() {
    return const TabBarView(
      children: [
        GalleryPage(),
        MapPage(),
      ],
    );
  }
}
