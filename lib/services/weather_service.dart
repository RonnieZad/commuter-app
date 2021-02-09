import 'package:commuter/constants/sercrets.dart';
import 'package:commuter/models/weather_model.dart';
import 'package:commuter/utils/customToast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeahterService {
  WeahterService._privateConstructor();

  static final WeahterService instance = WeahterService._privateConstructor();
  var data;

  queryWeather(String city) async {
    var apikEY = Secrets.OPENWEATHER_API_KEY;
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikEY";

    apiRequest(url);
  }

  apiRequest(
    String url,
  ) async {
    try {
      final response = await http.post(
        url,
      );

      if (response.statusCode == 200) {
        print(response.body);

        Map results = json.decode(response.body);
        WeatherModel user = WeatherModel.fromJson(results);
        data = user;
        return user;
      } else {
        CustomToast.instance.showToast(
            'Can\'t update weather, check your internet',
            Colors.red,
            Colors.white);
        print('Something went wrong');
      }
    } on Exception catch (e) {
      CustomToast.instance.showToast(
          'Can\'t update weather, check your internet',
          Colors.red,
          Colors.white);
      print('CAUGHT ERROR HERE : ' + e.toString());
    }
  }
}
