import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng) onSelectPosition;

  const LocationInput({
    Key? key,
    required this.onSelectPosition,
  }) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }

      final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });

      widget.onSelectPosition(
        LatLng(
          locationData.latitude!,
          locationData.longitude!,
        ),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: selectedPosition.latitude,
      longitude: selectedPosition.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text("Localização não informada"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: () => _getCurrentUserLocation(),
              icon: const Icon(Icons.location_on),
              label: const Text("Localização Atual"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text("Selecione no Mapa"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
