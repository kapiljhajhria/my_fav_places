const GOOGLE_API_KEY = "";

class LocationHelper {
  static String generateLocationPreviewImage(
      double latitude, double longitude) {
    // final String url =
    //     "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
    // ignore: avoid_escaping_inner_quotes
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}
