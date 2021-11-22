import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.placesListScreen: (ctx) => PlacesListScreen(),
          AppRoutes.placesFormScreen: (ctx) => PlaceFormScreen(),
          AppRoutes.placeDetailScreen: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
