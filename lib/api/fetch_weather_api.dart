import 'dart:convert';

import 'package:weatherapp/api/api_key.dart';
import 'package:weatherapp/models/weather_data.dart';
import 'package:http/http.dart' as http;

import '../models/weather_current_data.dart';
import '../models/weather_data_daily.dart';
import '../models/weather_data_hourly.dart';

class FetchWeatherApi {
  WeatherData? weatherData;
  Future<WeatherData> fetchWeatherData(lat, lon) async {
    // Processing the weather data from response to json;
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var data = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(data),
      WeatherDataHourly.fromJson(data),
      WeatherDataDaily.fromJson(data),
    );

    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&exclude=minutely&units=metric";

  return url;
}
