// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_current_data.dart';
import 'package:weatherapp/utils/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent currentWeatherData;
  const CurrentWeatherWidget({
    Key? key,
    required this.currentWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // temperature area
        TemperatureAreaWidget(),
        const SizedBox(
          height: 20,
        ),
        // more details area
        CurrentWeatherAreaWidget(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget CurrentWeatherAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                "assets/icons/windspeed.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${currentWeatherData.current.windSpeed} km/h",
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                "assets/icons/humidity.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${currentWeatherData.current.humidity}%",
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                "assets/icons/clouds.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${currentWeatherData.current.clouds}%",
            ),
          ],
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget TemperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
            "assets/weather/${currentWeatherData.current.weather![0].icon}.png"),
        Container(
          width: 1,
          height: 50,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "${currentWeatherData.current.temp!.toInt()}",
              style: const TextStyle(
                color: CustomColors.textColorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Transform.translate(
                offset: const Offset(0.0, -30.0),
                child: const Text(
                  "°C",
                  style: TextStyle(
                    color: CustomColors.textColorBlack,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: "${currentWeatherData.current.weather![0].description}",
              style: const TextStyle(
                color: CustomColors.textColorBlack,
                fontWeight: FontWeight.w200,
                fontSize: 14,
              ),
            )
          ],
        )),
      ],
    );
  }
}
