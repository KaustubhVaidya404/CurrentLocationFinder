import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  Position? _currentposition;

  Future<bool> _handleCurrentLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location permission disabled")));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location permission denied")));
        return false;
      }
    }
    if(permission == LocationPermission.deniedForever){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location permission denied forever")));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleCurrentLocationPermission();
    if(!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentposition = position;
      });
    }).catchError((e){
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Center buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Latitude : ${_currentposition?.latitude ?? ""}',
            style: const TextStyle(
              fontSize: 30,
              //fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'Longitude : ${_currentposition?.longitude?? ""}',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(onPressed: _getCurrentPosition, child: const Text("Get Your Current Location"))
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Your Current Location"),
    );
  }
}



