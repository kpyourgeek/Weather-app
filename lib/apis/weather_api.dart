import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String url = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherApi(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$url?q=$cityName&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    // getting permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // getting current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 20));
    // convert location to list of place marks objects
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract city from first place mark
    String city = placemark[0].locality.toString();
    return city;
  }
}
