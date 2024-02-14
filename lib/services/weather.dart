import 'dart:developer';
import 'package:clima_flutter_examples/services/location.dart';
import 'package:clima_flutter_examples/services/networking.dart';

const apikeys = 'b6effb0cd478a77e4317fcecbefd7c95';
const constvalue = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getcityweather(String cityname) async {
    Networkinghelper networkinghelper =
        Networkinghelper('$constvalue?q=$cityname&appid=$apikeys&units=metric');
    var weatherdata = await networkinghelper.getdata();
    return weatherdata;
  }

  double? latitude;
  double? lontitude;

  Future<dynamic> getweatherdata() async {
    Locations locations = Locations();
    await locations.getcurrentlocation();
    log(locations.toString());

    latitude = locations.lantitude;
    lontitude = locations.lontitude;
    if (latitude != null && lontitude != null) {
      Networkinghelper networkinghelper = Networkinghelper(
          '$constvalue?lat=$latitude&lon=$lontitude&appid=$apikeys&units=metric');
      var weatherdata = await networkinghelper.getdata();
      log("now weather =$weatherdata");
      return weatherdata;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
