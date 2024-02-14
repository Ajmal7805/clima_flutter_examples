import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class Locations {
  double? lantitude;
  double? lontitude;

  Future<void> getcurrentlocation() async {
    try {
      //check location permission true or false
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      //if permission is false go to _showdeniedpopup()
      if (locationPermission == LocationPermission.denied) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log("permission denied");
        }
      }
      //when permission is true, get lantitude and lontitude of the current space
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      lantitude = position.latitude;
      lontitude = position.longitude;

      log('current location $position');
    } catch (e) {
      log('Errors when calling getlocationfunction $e');
    }
  }
}
