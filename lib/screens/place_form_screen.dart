import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/components/image_input.dart';
import 'package:great_places/components/location_input.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  File? _pickedImage;
  LatLng? _pickedPosition;
  final _titleController = TextEditingController();

  void _setPickedImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValid() {
    if (_titleController.text.isEmpty) return false;
    if (_titleController.text.trim().isEmpty) return false;
    if (_pickedImage == null) return false;
    if (_pickedPosition == null) return false;

    return true;
  }

  void _submitForm() {
    if (!_isValid()) return;

    Provider.of<GreatPlacesProvider>(context, listen: false).addItem(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Lugar"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Título'),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _setPickedImage),
                    const SizedBox(height: 10),
                    LocationInput(onSelectPosition: _selectPosition),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _isValid() ? _submitForm : null,
            icon: const Icon(Icons.add),
            label: const Text("Adicionar"),
            color: Theme.of(context).accentColor,
            elevation: 0,
            //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
