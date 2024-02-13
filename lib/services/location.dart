import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Locations {
  double? lantitude;
  double? lontitude;

  Future<void> getcurrentlocation(BuildContext contexts) async {
    try {
      //check location permission true or false
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      //if permission is false go to _showdeniedpopup()
      if (locationPermission == LocationPermission.denied) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (contexts.mounted) {
            return showDialog<void>(
              context: contexts,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Align(
                      alignment: Alignment.topCenter, child: Text('Sorry')),
                  content: const Text(
                      "You don't have permission to go foward ,If you want to go forward definitly you enable allow button"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Approve'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
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
