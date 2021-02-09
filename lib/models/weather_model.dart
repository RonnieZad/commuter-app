import 'package:flutter/material.dart';

class WeatherModel {
  @required
  final String city;
  final List<WeatherQuality> quality;
  final List<WeatherDescription> description;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] as String,
      description: List<WeatherDescription>.from(
        json["weather"].map(
          (item) {
            return new WeatherDescription(
                condition: item["main"],
                description: item["description"],
                id: item['id']);
          },
        ),
      ).toList(),
    );
  }

  WeatherModel({
    this.city,
    this.quality,
    this.description,
  });
}

class WeatherDescription {
  final String condition;
  final String description;
  final int id;

  WeatherDescription({this.condition, this.description, this.id});
}

class WeatherQuality {
  final String temperature;
  final String pressure;

  WeatherQuality({this.temperature, this.pressure});
}
