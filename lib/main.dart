import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/ui/weather_page.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/repo/weather_repo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherNotifier(weatherRepository: WeatherRepository(api: OpenWeatherMapAPI('69b567e5aa5c1f162003d73827650011'))),
      child: MaterialApp(
        title: 'Weather App',
        home: const WeatherPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
