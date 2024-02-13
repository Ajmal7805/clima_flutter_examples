// ignore_for_file: prefer_const_constructors

import 'package:clima_flutter_examples/screens/locationscreen.dart';
import 'package:clima_flutter_examples/utilities/const.dart';
import 'package:clima_flutter_examples/services/location.dart';
import 'package:clima_flutter_examples/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  double? latitude;
  double? lontitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitCircle(
        color: Colors.red,
        size: 60.0,
      )),
    );
  }

  Future<void> getlocationdata() async {
    Locations locations = Locations();
    await locations.getcurrentlocation(context);

    latitude = locations.lantitude;
    lontitude = locations.lontitude;
    if (latitude != null && lontitude != null) {
      Networkinghelper networkinghelper = Networkinghelper(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$lontitude&appid=$apikeys&units=metric');
      var weatherdata = await networkinghelper.getdata();

      if (mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Locationscreen(
              locationweather: weatherdata,
            );
          },
        ));
      }
    }
  }
}
