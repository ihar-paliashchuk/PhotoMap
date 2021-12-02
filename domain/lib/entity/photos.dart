import 'package:equatable/equatable.dart';

class Photos extends Equatable {
  final String id;
  final String description;
  final String latitude;
  final String longitude;
  final List<String> urls;

  const Photos({
    required this.id,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.urls,
  });

  @override
  List<Object?> get props => [id, description, latitude, longitude, urls];
}
