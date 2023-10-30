import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/api/fetch_weather_api.dart';
import 'package:weatherapp/models/weather_data.dart';

class GlobalController extends GetxController {
  // create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final weatherData = WeatherData().obs;
  final RxInt _currentIndex = 0.obs;
  //instance for them to be called
  RxBool cheakLoding() => _isLoading;
  RxDouble lattitude() => _latitude;
  RxDouble longitude() => _longitude;
  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
 
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnable;
    LocationPermission locationPermission;
    isServiceEnable = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled
    if (!isServiceEnable) {
      return Future.error("Service is not enable");
    }
    // status of permission
    locationPermission = await Geolocator.checkPermission();
    // return if permission is not granted
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is deniedForever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      // return if permission is not granted
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    // getting current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) {
      //update latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
      return FetchWeatherApi()
          .fetchWeatherData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;

        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
