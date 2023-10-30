// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weatherapp/models/weather_current_data.dart';
import 'package:weatherapp/models/weather_data_daily.dart';
import 'package:weatherapp/models/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  WeatherData([this.current, this.hourly, this.daily]);
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
