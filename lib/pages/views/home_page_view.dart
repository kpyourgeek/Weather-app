import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/apis/weather_api.dart';
import 'package:my_weather/models/weather_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
// APi key
  final _weatherApi = WeatherApi('10e9345e8c8aa22d75c189fd91aa0344');
  Weather? _weather;
// Weather fetch
  _fetchWeather() async {
// current city
    String currentCity = await _weatherApi.getCurrentCity();
    // weather for the city
    try {
      final weather = await _weatherApi.getWeather(currentCity);
      setState(() {
        _weather = weather;
      });
    }
    // print error to console
    catch (e) {
      return e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }
// weather animations

  String weatherAnimations(String? weatherCondtion) {
    // if (weatherCondtion == null) return 'Your weather is Clear';
    switch (weatherCondtion) {
      case 'clouds || overcast clouds || broken clouds || haze || smoke || mist || fog || haze':
        return 'assets/cloudy.json';

      case 'clear sky':
        return 'assets/sunny.json';

      case 'thunderstorm || drizzle || rain || freezing rain || snow || sleet || mist || smoke || haze || fog || dust || ash || squall || tornado':
        return 'assets/raining_thunder.json';

      case 'raining || rain':
        return 'assets/raining_sunny.json';

      default:
        return 'assets/cloudy.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 122, 139, 139),
      appBar: AppBar(
        title: Text(
          'Your daily weather App',
          style: GoogleFonts.rubik(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400],
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 139, 139),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _weather?.cityName ?? 'City ...',
                    style: GoogleFonts.rubik(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],

                      // color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    _weather?.weatherCondtion ?? 'Weather ...',
                    style: GoogleFonts.rubik(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],

                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Lottie.asset(weatherAnimations(_weather?.weatherCondtion)),
              const SizedBox(height: 40),
              Text(
                '${_weather?.temperature.toString()} °C',
                style: GoogleFonts.rubik(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
