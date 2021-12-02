import 'package:core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_event.dart';
import 'package:presentation/pages/gallery.dart';
import 'package:presentation/pages/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = [
    const Tab(icon: Icon(Icons.photo_album)),
    const Tab(icon: Icon(Icons.map)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(_handleTabSelection);
  }

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

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 1:
          BlocProvider.of<PhotosBloc>(context)
              .add(const GetPhotosEvent(userId: userId));
          break;
      }
    }
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
