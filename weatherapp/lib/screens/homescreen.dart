import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class HomeWeatherScreen extends StatefulWidget {
  const HomeWeatherScreen({super.key});

  @override
  State<HomeWeatherScreen> createState() => _HomeWeatherScreenState();
}

class _HomeWeatherScreenState extends State<HomeWeatherScreen> {


  @override
  Widget build(BuildContext context) {
    var currenttime = DateTime.now();
    DateFormat dateFormat = DateFormat.Hm();


    List<dynamic> apidata = [];
    Position? _currentposition;

    Future<bool> _handleCurrentLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission disabled")));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Location permission denied")));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission denied forever")));
        return false;
      }
      return true;
    }

    Future<void> _getCurrentPosition() async {
      final hasPermission = await _handleCurrentLocationPermission();
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() {
          _currentposition = position;
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    void fetchData() async{
      debugPrint("Start");
      final uri = Uri.parse("http://api.openweathermap.org/data/2.5/weather?lat=${_currentposition!.latitude}&lon=${_currentposition!.longitude}&units=metric&APPID=bca4c490dea603e0fdfc12f63c6b7257");
      final response = await http.get(uri);
      final body = jsonDecode(response.body);
      setState(() {
        apidata = body["weather"];
        debugPrint("Data loaded to list");
      });
      debugPrint("End");
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Column(
            children: [
              const Text(
                    'Climate'
              ),
              Row(
                children: [
                  Text(
                      '$currenttime',
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  Text(
                      '$dateFormat',
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  )
                ],
              )
            ],
          )
      ),
      body: Center(
        child: ElevatedButton(onPressed: () { fetchData(); }, child: const Text("Press")
        ),
      ),
    );
  }


}



