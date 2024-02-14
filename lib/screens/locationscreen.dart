// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clima_flutter_examples/screens/city_Screen.dart';
import 'package:clima_flutter_examples/services/weather.dart';
import 'package:clima_flutter_examples/utilities/const.dart';
import 'package:flutter/material.dart';

class Locationscreen extends StatefulWidget {
  final dynamic locationweather;
  const Locationscreen({
    super.key,
    this.locationweather,
  });

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  WeatherModel weatherModel = WeatherModel();

  int? temparature;
  String? weathericon;
  String? cityname;
  String? weathermessage;
  @override
  void initState() {
    super.initState();
    updateui(widget.locationweather);
  }

  void updateui(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temparature = 0;
        weathericon = 'Error';
        weathermessage = 'Unable to get weather data';
        cityname = '';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temparature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      weathericon = weatherModel.getWeatherIcon(condition);
      weathermessage = weatherModel.getMessage(temparature!.toInt());
      cityname = weatherdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "$weathermessage in $cityname!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temparature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        var refreshdata = await weatherModel.getweatherdata();
                        updateui(refreshdata);
                      },
                      icon: Icon(
                        Icons.near_me,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var typedname =
                            await Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ));
                        if (typedname != null) {
                          var weatherdata =
                              await weatherModel.getcityweather(typedname);
                          updateui(weatherdata);
                        }
                      },
                      icon: Icon(
                        Icons.location_city,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
