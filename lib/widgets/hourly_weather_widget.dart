// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/controller/globel_controller.dart';
import 'package:weatherapp/utils/custom_colors.dart';

import '../models/weather_data_hourly.dart';

// ignore: must_be_immutable
class HourlyWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyWeatherWidget({
    Key? key,
    required this.weatherDataHourly,
  }) : super(key: key);
// card index
  RxInt cardIndex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Today",
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        HourlyList()
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget HourlyList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        // shrinkWrap: true,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (BuildContext context, int index) {
          
          if (weatherDataHourly.hourly.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return Obx(() => GestureDetector(
                  onTap: () {
                    cardIndex.value = index;
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.dividerLine.withAlpha(150),
                          blurRadius: 30,
                          spreadRadius: 1,
                          offset: const Offset(0.5, 0),
                        )
                      ],
                      gradient: cardIndex == index
                          ? const LinearGradient(
                              colors: [
                                CustomColors.firstGradientColor,
                                CustomColors.secondGradientColor,
                              ],
                            )
                          : null,
                    ),
                    child: HourlyDetailsCard(
                      index: index,
                      cardIndex: cardIndex.value,
                      timeStamp: weatherDataHourly.hourly[index].dt!,
                      temp: weatherDataHourly.hourly[index].temp!.toInt(),
                      weatherIcon:
                          weatherDataHourly.hourly[index].weather![0].icon!,
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}

//hourly details
// ignore: must_be_immutable
class HourlyDetailsCard extends StatelessWidget {
  HourlyDetailsCard({
    super.key,
    required this.timeStamp,
    required this.temp,
    required this.weatherIcon,
    required this.index,
    required this.cardIndex,
  });
  int temp;
  int timeStamp;
  String weatherIcon;
  int cardIndex;
  int index;
  String getTime() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat.jm().format(date);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          getTime(),
          style: TextStyle(
            color:
                cardIndex == index ? Colors.white : CustomColors.textColorBlack,
          ),
        ),
        Container(
          child: Image.asset("assets/weather/$weatherIcon.png"),
        ),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "$temp",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextSpan(
              text: "°C",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
