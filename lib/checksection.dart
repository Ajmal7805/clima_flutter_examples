// import 'dart:html';

// import 'package:flutter/material.dart';

// class CheckSection extends StatefulWidget {
//   const CheckSection({super.key});

//   @override
//   State<CheckSection> createState() => _CheckSectionState();
// }

// class _CheckSectionState extends State<CheckSection> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }

//   void getlocation() async {
//     Location locationobject = location();
//     await locationobject.getlocation();
//     latitude = locationobject.latitude;
//     lonitude = locationobject.lonitude;
//     networkhelper Networkhelper = networkhelper(
//         'https://api.weatherapi.com/v1/current.json?key=$apikeys&q=$latitude,$lonitude');

//     var weatherdata = await Networkhelper.getdata();
//     Navigator.push(context, MaterialPageRoute(
//       builder: (context) {
//         return LocationScreen(locationweather: weatherdata,);
        
//       },
//     ));
//   }
// }
