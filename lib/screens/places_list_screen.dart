import 'package:flutter/material.dart';
import 'package:my_fav_places/models/place.dart';
import 'package:my_fav_places/providers/great_places.dart';
import 'package:my_fav_places/screens/add_place_screen.dart';
import 'package:my_fav_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Fav Places"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<GreatPlaces>(
            builder: (ctx, greatPlaces, _child) {
              if (greatPlaces.places.isEmpty) {
                return _child!;
              }
              return ListView.builder(
                itemCount: greatPlaces.places.length,
                itemBuilder: (BuildContext context, int index) {
                  final Place place = greatPlaces.places[index];
                  return ListTile(
                    onTap: () {
                      //go to details page
                      Navigator.of(context).pushNamed(
                          PlaceDetailScreen.routeName,
                          arguments: place.id);
                    },
                    title: Text(place.title),
                    subtitle: Text(place.location!.address.toString()),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(place.image),
                    ),
                  );
                },
              );
            },
            child: const Center(
              child: Text("No Places addet yet, Get started now"),
            ),
          );
        },
      ),
    );
  }
}
