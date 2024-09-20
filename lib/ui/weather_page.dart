// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/services/location_service.dart';
// import 'package:weather_app/ui/widgets/city_search_box.dart';
// import 'package:weather_app/provider/weather_provider.dart';
// import 'widgets/current_weather.dart';
// import 'widgets/hourly_weather.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   final LocationService _locationService = LocationService();
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       fetchWeather();
//     });
//     super.initState();
//   }

//   Future<void> fetchWeather() async {
//     // Get the current city name
//     String city = await _locationService.getCurrentCity();
//     // Fetch weather data for the current city
//     if (mounted) {
//       Provider.of<WeatherNotifier>(context, listen: false).fetchWeather(city);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final weatherNotifier = Provider.of<WeatherNotifier>(context);
//     return Scaffold(
//       // appBar: AppBar(title: const Text("Weather App")),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 60,
//           ),
//           const CitySearchBox(),
//           Expanded(
//             child: weatherNotifier.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView(
//                     children: const [
//                       CurrentWeather(),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       HourlyWeather(),
//                       SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/ui/widgets/city_search_box.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'widgets/current_weather.dart';
import 'widgets/hourly_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final LocationService _locationService = LocationService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentCityAndFetchWeather();
  }

  Future<void> _getCurrentCityAndFetchWeather() async {
    String cityName = await _locationService.getCurrentCity();
    Provider.of<WeatherNotifier>(context, listen: false).fetchWeather(cityName);
    setState(() {
      _isLoading = false; // Set loading to false after fetching weather
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = Provider.of<WeatherNotifier>(context);

    return Scaffold(
      // appBar: AppBar(title: const Text("Weather App")),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const CitySearchBox(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : weatherNotifier.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: const [
                          CurrentWeather(),
                          SizedBox(height: 30),
                          HourlyWeather(),
                          SizedBox(height: 30),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
