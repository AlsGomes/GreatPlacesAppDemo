import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationUtil {
  static const String _googleApiKey = 'AIzaSyA4K8wnetF43XzScCIpPn03dHnh5aYT6oc';

  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$_googleApiKey';
  }

  static Future<String> getAddressfrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_googleApiKey';
    final res = await http.get(Uri.parse(url));
    return jsonDecode(res.body)['results'][0]['formatted_address'];
  }
}
