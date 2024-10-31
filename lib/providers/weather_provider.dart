import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? weather;
  final WeatherService _weatherService = WeatherService();

  Future<void> getWeather(String cityName) async {
    weather = await _weatherService.fetchWeather(cityName);
    notifyListeners();
  }
}
