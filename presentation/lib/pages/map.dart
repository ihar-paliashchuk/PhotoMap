import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return FutureBuilder<BitmapDescriptor>(
        future: createCustomMapPin(),
        builder:
            (BuildContext context, AsyncSnapshot<BitmapDescriptor> snapshot) {
          return BlocBuilder<PhotosBloc, PhotosState>(
              builder: (context, state) {
            Widget stateWidget = const Spacer();
            if (state is PhotosLoading) {
              stateWidget = const Center(child: CircularProgressIndicator());
            } else if (state is PhotosError) {
              stateWidget = const Center(child: Text("Error"));
            } else if (state is PhotosSuccess) {
              _markers = Map.fromEntries(state.photos.map((photo) => MapEntry(
                  MarkerId(photo.id),
                  Marker(
                    markerId: MarkerId(photo.id),
                    position: LatLng(double.parse(photo.latitude),
                        double.parse(photo.longitude)),
                    icon: snapshot.data ?? BitmapDescriptor.defaultMarker,
                    infoWindow: InfoWindow(
                        title: photo.description,
                        snippet: "see more",
                        onTap: () {
                        }),
                  ))));
              return Scaffold(
                body: 
                // Stack(children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(53.893009, 27.567444),
                      zoom: 5.0,
                    ),
                    markers: Set<Marker>.of(_markers.values),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer()),
                    },
                  ),
                  // stateWidget,
                // ]),
              );
            }
            return stateWidget;
          });
        });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<BitmapDescriptor> createCustomMapPin() async {
    return await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/pin_red.png');
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
