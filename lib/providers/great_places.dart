import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_fav_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places {
    return _places;
  }

  void addPlace(String title, File image) {
    final Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _places.add(newPlace);
    notifyListeners();
  }
}
