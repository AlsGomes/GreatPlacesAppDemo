import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = "",
  });

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });

  static Map<String, dynamic> toMapWithoutLocation(Place place) {
    return {
      "id": place.id,
      "title": place.title,
      "image": place.image.path,
    };
  }

  static Map<String, dynamic> toMap(Place place) {
    return {
      "id": place.id,
      "title": place.title,
      "image": place.image.path,
      "latitude": place.location!.latitude,
      "longitude": place.location!.longitude,
      "address": place.location!.address,
    };
  }

  static Place fromMap(Map<String, dynamic> data) {
    return Place(
      id: data['id'],
      title: data['title'],
      image: File(data['image']),
      location: PlaceLocation(
        latitude: data['latitude'],
        longitude: data['longitude'],
        address: data['address'],
      ),
    );
  }
}
