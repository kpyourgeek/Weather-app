// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String cityName;
  final double temperature;
  final String weatherCondtion;
  Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherCondtion,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] as String,
      temperature: json['main']['temp'] as double, // Now a double
      weatherCondtion: json['weather'][0]['main'] as String,
    );
  }
}
