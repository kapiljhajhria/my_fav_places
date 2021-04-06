import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_fav_places/helpers/location_helper.dart';
import 'package:my_fav_places/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        locationData.latitude!, locationData.longitude!);
    debugPrint(staticMapImageUrl);
    print(locationData.accuracy);
    print(locationData.longitude);
    print(locationData.latitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLoaction = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLoaction == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Location Selected")));
      return;
    }
    debugPrint("selected location ${selectedLoaction.latitude}");
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        selectedLoaction.latitude, selectedLoaction.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(1),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).primaryColor),
              ),
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).primaryColor),
              ),
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
