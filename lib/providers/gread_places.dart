import 'package:flutter/material.dart';
import 'package:my_fav_places/models/place.dart';

class GreapPlaces with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places {
    return _places;
  }
}
