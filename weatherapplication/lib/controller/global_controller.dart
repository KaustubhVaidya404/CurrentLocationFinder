import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {

  final RxBool _isloading = true.obs;
  final RxDouble _latitite = 0.0.obs;
  final RxDouble _longitute = 0.0.obs;

  RxBool checkLoading() => _isloading;

  RxDouble getLatitude() => _latitite;

  RxDouble getLongitude() => _longitute;

  @override
  void onInit() {
    if (!_isloading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    ).then((value) {
      _latitite.value = value.latitude;
      _longitute.value = value.longitude;
      _isloading.value = false;
    });
  }
}


