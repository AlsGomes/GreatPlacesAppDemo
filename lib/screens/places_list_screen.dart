import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Lugares"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.placesFormScreen),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(
          context,
          listen: false,
        ).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const CircularProgressIndicator()
            : Consumer<GreatPlacesProvider>(
                child: const Center(child: Text("Nenhum lugar cadastrado")),
                builder: (ctx, greatPlacesProvider, child) =>
                    greatPlacesProvider.itemsCount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlacesProvider.itemsCount,
                            itemBuilder: (ctx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlacesProvider.itemByIndex(index).image,
                                ),
                              ),
                              title: Text(
                                greatPlacesProvider.itemByIndex(index).title,
                              ),
                              subtitle: Text(
                                greatPlacesProvider
                                    .itemByIndex(index)
                                    .location!
                                    .address!,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.placeDetailScreen,
                                  arguments:
                                      greatPlacesProvider.itemByIndex(index),
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
