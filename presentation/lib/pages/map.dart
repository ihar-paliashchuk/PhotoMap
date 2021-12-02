import 'package:core/config/config.dart';
import 'package:domain/entity/photos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:presentation/bloc/photos_bloc.dart';
import 'package:presentation/bloc/photos_event.dart';
import 'package:presentation/bloc/photos_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return _buildWiget();
  }

  Widget _buildWiget() {
    return FutureBuilder<BitmapDescriptor>(
        future: createCustomMapPin(),
        builder: (
          BuildContext context,
          AsyncSnapshot<BitmapDescriptor> snapshot,
        ) {
          return BlocBuilder<PhotosBloc, PhotosState>(
              builder: (context, state) {
            if (state is PhotosSuccess) {
              return Scaffold(
                body: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(53.893009, 27.567444),
                    zoom: 5.0,
                  ),
                  markers: mapMarkers(
                    state.photos,
                    snapshot.data ?? BitmapDescriptor.defaultMarker,
                  ),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                ),
              );
            }
            return const Spacer();
          });
        });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Set<Marker> mapMarkers(
    List<Photos> photos,
    BitmapDescriptor bitmapDescriptor,
  ) {
    return photos.map((photo) {
      return Marker(
        markerId: MarkerId(photo.id),
        position: LatLng(
          double.parse(photo.latitude),
          double.parse(photo.longitude),
        ),
        icon: bitmapDescriptor,
        infoWindow: InfoWindow(
            title: photo.description,
            snippet: "see more",
            onTap: () => _openPhotos(photo)),
      );
    }).toSet();
  }

  void _openPhotos(Photos spotos) {
    BlocProvider.of<PhotosBloc>(context).add(GetPhotosByLocationEvent(
        userId: userId,
        latitude: spotos.latitude,
        longitude: spotos.longitude));
    DefaultTabController.of(context)?.animateTo(0);
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
