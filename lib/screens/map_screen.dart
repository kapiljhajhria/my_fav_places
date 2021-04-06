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
  LatLng? _pickedLoaction;
  late Set<Marker> _marker;

  void _selectLocation(LatLng loc) {
    setState(() {
      _pickedLoaction = loc;
      // _marker = <Marker>{
      //   Marker(markerId: const MarkerId("m1"), position: loc),
      // };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: _pickedLoaction == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLoaction ??
                            LatLng(widget.initialLocation.lat,
                                widget.initialLocation.long));
                      })
        ],
        title: const Text("Your Map"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLoaction == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLoaction ??
                        LatLng(widget.initialLocation.lat,
                            widget.initialLocation.long))
              },
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
