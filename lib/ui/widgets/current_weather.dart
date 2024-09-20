// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/ui/widgets/weather_icon_image.dart';
// import 'package:weather_app/model/weather_model.dart';
// import 'package:weather_app/provider/weather_provider.dart'; // Your WeatherNotifier

// class CurrentWeather extends StatelessWidget {
//   const CurrentWeather({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final weatherNotifier = Provider.of<WeatherNotifier>(context);
//     final city = weatherNotifier.city;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Add the search box
//         const SizedBox(height: 20),
//         Text(city, style: Theme.of(context).textTheme.headlineMedium),
//         if (weatherNotifier.isLoading)
//           const Center(child: CircularProgressIndicator())
//         else if (weatherNotifier.currentWeather != null)
//           CurrentWeatherContents(data: weatherNotifier.currentWeather!)
//         else
//           Text('Error: ${weatherNotifier.errorMessage}'),
//       ],
//     );
//   }
// }

// class CurrentWeatherContents extends StatelessWidget {
//   const CurrentWeatherContents({super.key, required this.data});
//   final WeatherData data;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     final temp = data.temp.toInt().toString();
//     final minTemp = data.minTemp.toInt().toString();
//     final maxTemp = data.maxTemp.toInt().toString();
//     final highAndLow = 'H:$maxTemp° L:$minTemp°';

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         WeatherIconImage(iconUrl: data.iconUrl, size: 120),
//         Text(temp, style: textTheme.displayMedium),
//         Text(highAndLow, style: textTheme.bodyMedium),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/widgets/weather_icon_image.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart'; // Your WeatherNotifier

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = Provider.of<WeatherNotifier>(context);
    final city = weatherNotifier.city;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(city, style: Theme.of(context).textTheme.headlineMedium),
        if (weatherNotifier.currentWeather != null)
          CurrentWeatherContents(data: weatherNotifier.currentWeather!)
        else
          Text('Error: ${weatherNotifier.errorMessage}'),
      ],
    );
  }
}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.main?.temp?.toInt().toString();
    final minTemp = data.main?.tempMin?.toInt().toString();
    final maxTemp = data.main?.tempMax?.toInt().toString();
    final humidity = data.main?.humidity?.toString();
    final pressure = data.main?.pressure?.toString();
    final windSpeed = data.wind?.speed?.toString();
    final description = data.weather?.isNotEmpty == true ? data.weather![0].description : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(
          iconUrl: 'http://openweathermap.org/img/wn/${data.weather?.isNotEmpty == true ? data.weather![0].icon : "01d"}@4x.png',
          size: 200,
        ),
        if (temp != null) Text(temp, style: textTheme.displayMedium),
        if (description != null) Text(description.capitalize(), style: textTheme.bodyMedium),
        if (minTemp != null && maxTemp != null)
          Text('H: $maxTemp° L: $minTemp°', style: textTheme.bodyMedium),
        if (humidity != null) Text('Humidity: $humidity%', style: textTheme.bodyMedium),
        if (pressure != null) Text('Pressure: $pressure hPa', style: textTheme.bodyMedium),
        if (windSpeed != null) Text('Wind Speed: $windSpeed m/s', style: textTheme.bodyMedium),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
