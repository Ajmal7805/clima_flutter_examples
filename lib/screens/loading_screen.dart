// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        //Get the current location
        onPressed: () {
          getlocation();
        },
        child: Text('Get Location'),
      )),
    );
  }

  //to get current location
  Future<void> getlocation() async {
    //check location permission true or false
    LocationPermission locationPermission = await Geolocator.checkPermission();
    //if permission is false go to _showdeniedpopup()
    if (locationPermission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return _showdeniedpopup();
      }
    }
    //when permission is true, get lantitude and lontitude of the current space
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    log('current location $position');
  }

  //pop up to show when the user is clicked denied access
  Future<void> _showdeniedpopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Align(alignment: Alignment.topCenter, child: const Text('Sorry')),
          content: Text(
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
