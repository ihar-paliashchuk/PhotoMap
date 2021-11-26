import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

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
    return TabBarView(
      children: [
        const Icon(Icons.photo_album),
        _buildGoogleMap(),
      ],
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(45.521563, -122.677433),
        zoom: 11.0,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
