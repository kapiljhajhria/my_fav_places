import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_fav_places/helpers/db_helper.dart';
import 'package:my_fav_places/helpers/location_helper.dart';
import 'package:my_fav_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return _places;
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLoaction) async {
    //convert location to human readable location
    final String address = await LocationHelper.getPlaceAddress(
        pickedLoaction.lat, pickedLoaction.long);
    final updatedLocation = PlaceLocation(
        lat: pickedLoaction.lat, long: pickedLoaction.long, address: address);

    final Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.lat,
      'loc_long': newPlace.location!.long,
      'address': newPlace.location!.address!
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    final parsedDataList = dataList
        .map((pl) => Place(
            id: pl['id'].toString(),
            image: File(pl['image'].toString()),
            location: PlaceLocation(
                lat: double.parse(pl['loc_lat'].toString()),
                long: double.parse(pl['loc_long'].toString()),
                address: pl['address'].toString()),
            title: pl['title'].toString()))
        .toList();
    _places = parsedDataList;
    notifyListeners();
  }
}
