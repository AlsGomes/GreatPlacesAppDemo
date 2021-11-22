import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> addItem(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressfrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
      image: image,
    );

    _items.add(newPlace);
    DbUtil.insert('places', Place.toMap(newPlace));
    notifyListeners();
  }

  Future<void> fetchPlaces() async {
    final places = await DbUtil.getData('places');
    _items = places.map((item) => Place.fromMap(item)).toList();
    notifyListeners();
  }
}
