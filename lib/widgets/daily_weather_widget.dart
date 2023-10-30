// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/models/weather_data_daily.dart';
import 'package:weatherapp/utils/custom_colors.dart';

class DAilyWeatherWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DAilyWeatherWidget({
    Key? key,
    required this.weatherDataDaily,
  }) : super(key: key);

  // String getDay(int day) {
  //   DateTime time = DateTime.fromMicrosecondsSinceEpoch(day * 1000);
  //   final x = DateFormat.EEEE().format(time);
  //   return x;
  // }
  String getDay(int day) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    String x = DateFormat.EEEE().format(date);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Next Days",
            style: TextStyle(
              fontSize: 20,
              color: CustomColors.textColorBlack.withAlpha(150),
              letterSpacing: 1.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DailyList(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget DailyList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 500,
      child: ListView.builder(
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int index) {
          if (weatherDataDaily.daily.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDay(weatherDataDaily.daily[index].dt!),
                  style: const TextStyle(
                    fontSize: 17,
                    color: CustomColors.textColorBlack,
                    letterSpacing: 1.3,
                  ),
                ),
                Image.asset(
                  "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                  height: 60,
                ),
                // Text(
                //     "${weatherDataDaily.daily[index].temp!.max!.toInt()} / ${weatherDataDaily.daily[index].temp!.min!.toInt()}")
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${weatherDataDaily.daily[index].temp!.max!.toInt()}/${weatherDataDaily.daily[index].temp!.min!.toInt()}",
                      style: const TextStyle(
                        color: CustomColors.textColorBlack,
                        fontSize: 20,
                        letterSpacing: 1.3,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.top,
                      child: Transform.translate(
                        offset: const Offset(0.0, -2.0),
                        child: const Text(
                          "°c",
                          style: TextStyle(
                            color: CustomColors.textColorBlack,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            );
          }
        },
      ),
    );
  }
}
