import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "API_KEY_HERE";

class LocationHelper {
  static String generateLocationPreviewImage(
      double latitude, double longitude) {
    // final String url =
    //     "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
    // ignore: avoid_escaping_inner_quotes
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY";
    final http.Response response = await http.get(Uri.parse(url));
    return json
        .decode(response.body)['results'][0]['formatted_address']
        .toString();
  }
}
