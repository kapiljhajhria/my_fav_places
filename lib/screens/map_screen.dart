import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_fav_places/models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapsScreen(
      {this.initialLocation = const PlaceLocation(lat: 37.422, long: -122.084),
      this.isSelecting = false});
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Map"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,

        // mapToolbarEnabled: true,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target:
              LatLng(widget.initialLocation.lat, widget.initialLocation.long),
        ),
      ),
    );
  }
}
