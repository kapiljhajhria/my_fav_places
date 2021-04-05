import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_fav_places/helpers/db_helper.dart';
import 'package:my_fav_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

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
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    final parsedDataList = dataList
        .map((pl) => Place(
            id: pl['id'].toString(),
            image: File(pl['image'].toString()),
            location: null,
            title: pl['title'].toString()))
        .toList();
    _places = parsedDataList;
    notifyListeners();
  }
}
