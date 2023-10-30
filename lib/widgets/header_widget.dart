import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/controller/globel_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat.yMMMMd().format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity(
        globalController.lattitude().value, globalController.longitude().value);
  }

  getCity(lat, long) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
    setState(() {
      city = placemark[0].locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: const TextStyle(
            fontSize: 34,
            letterSpacing: 1.8,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}
