import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/globel_controller.dart';
import 'package:weatherapp/widgets/comfort_level.dart';
import 'package:weatherapp/widgets/current_weather_widget.dart';
import 'package:weatherapp/widgets/daily_weather_widget.dart';
import 'package:weatherapp/widgets/header_widget.dart';
import 'package:weatherapp/widgets/hourly_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Obx(
                () => globalController.cheakLoding().isTrue
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/loading.svg"),
                            const CircularProgressIndicator()
                          ],
                        ),
                      )
                    : Center(
                        child: ListView(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          children: [
                            const HeaderWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            // for our current template ["current"]
                            CurrentWeatherWidget(
                              currentWeatherData: globalController
                                  .getData()
                                  .getCurrentWeather(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // for our daily template ["daily"]
                            HourlyWeatherWidget(
                              weatherDataHourly:
                                  globalController.getData().getHourlyWeather(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // for our daily template

                            // comfort level
                            ComfortLevelWidget(
                              weatherDataCurrent: globalController
                                  .getData()
                                  .getCurrentWeather(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DAilyWeatherWidget(
                              weatherDataDaily:
                                  globalController.getData().getDailyWeather(),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
