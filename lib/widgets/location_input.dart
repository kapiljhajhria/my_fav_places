import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> getCurrentLocation() async {
    final locationData = await Location().getLocation();
    print(locationData.accuracy);
    print(locationData.longitude);
    print(locationData.latitude);
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
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
