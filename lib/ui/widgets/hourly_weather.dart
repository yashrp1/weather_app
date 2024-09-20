// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/ui/widgets/weather_icon_image.dart';
// import 'package:weather_app/model/weather_model.dart';
// import 'package:weather_app/provider/weather_provider.dart';
// import 'package:intl/intl.dart';

// class HourlyWeather extends StatelessWidget {
//   const HourlyWeather({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final weatherNotifier = Provider.of<WeatherNotifier>(context);
//     if (weatherNotifier.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (weatherNotifier.hourlyForecast != null) {
//       // API returns data points in 3-hour intervals -> 1 day = 8 intervals
//       final items = [0, 8, 16, 24, 32];
//       return HourlyWeatherRow(
//         weatherDataItems: [
//           for (var i in items) weatherNotifier.hourlyForecast!.list[i],
//         ],
//       );
//     } else {
//       return const Center(child: Text("Error loading weather data."));
//     }
//   }
// }

// class HourlyWeatherRow extends StatelessWidget {
//   const HourlyWeatherRow({super.key, required this.weatherDataItems});
//   final List<WeatherData> weatherDataItems;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: weatherDataItems
//           .map((data) => HourlyWeatherItem(data: data))
//           .toList(),
//     );
//   }
// }

// class HourlyWeatherItem extends StatelessWidget {
//   const HourlyWeatherItem({super.key, required this.data});
//   final WeatherData data;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     const fontWeight = FontWeight.normal;
//     final temp = data.temp.toInt().toString(); // Assuming temp is in Celsius

//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10)
//         ),
//         child: Column(
//           children: [
//             // Day of the week
//             Text(
//               DateFormat.E().format(data.date),
//               style: textTheme.bodySmall?.copyWith(fontWeight: fontWeight),
//             ),
//             const SizedBox(height: 8),
//             // Weather icon
//             WeatherIconImage(iconUrl: data.iconUrl, size: 48),
//             const SizedBox(height: 8),
//             // Temperature
//             Text(
//               '$temp°',
//               style: textTheme.bodyLarge?.copyWith(fontWeight: fontWeight),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/forecase_model.dart';
import 'package:weather_app/ui/widgets/weather_icon_image.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:intl/intl.dart';

class HourlyWeather extends StatelessWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = Provider.of<WeatherNotifier>(context);
    if (weatherNotifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (weatherNotifier.hourlyForecast != null && weatherNotifier.hourlyForecast!.list != null) {
      // API returns data points in 3-hour intervals -> 1 day = 8 intervals
      final items = [0, 8, 16, 24, 32];
      return HourlyWeatherRow(
        weatherDataItems: [
          for (var i in items) weatherNotifier.hourlyForecast!.list![i],
        ],
      );
    } else {
      return const Center(child: Text("Error loading weather data."));
    }
  }
}

class HourlyWeatherRow extends StatelessWidget {
  const HourlyWeatherRow({super.key, required this.weatherDataItems});
  final List<ForecastItem> weatherDataItems; // Change to ForecastItem

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: weatherDataItems
          .map((data) => HourlyWeatherItem(data: data))
          .toList(),
    );
  }
}

class HourlyWeatherItem extends StatelessWidget {
  const HourlyWeatherItem({super.key, required this.data});
  final ForecastItem data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Handle null checks for dt
    final time = data.dt != null
        ? DateTime.fromMillisecondsSinceEpoch(data.dt! * 1000)
        : ''; // Default if dt is null

    // Handle null checks for temperature and other fields
    final temp = data.main?.temp?.toInt().toString();
    final humidity = data.main?.humidity?.toString();
    final pressure = data.main?.pressure?.toString();
    final windSpeed = data.wind?.speed?.toString();
    final description = data.weather?.isNotEmpty == true ? data.weather![0].description : null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16), 
          // Left section: Time and Weather Icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                            const SizedBox(height: 8),

              Text(
                time != '' ? DateFormat.E().format(time as DateTime ) : '',
                style: textTheme.bodyLarge,
              ),
              WeatherIconImage(
                iconUrl: 'http://openweathermap.org/img/wn/${data.weather?.isNotEmpty == true ? data.weather![0].icon : "01d"}@2x.png',
                size: 60,
              ),
            ],
          ),
          const SizedBox(width: 16), // Space between left and right sections

          // Right section: Other Weather Data
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                if (humidity != null) Text('Humidity: $humidity%', style: textTheme.bodyMedium),
                if (pressure != null) Text('Pressure: $pressure hPa', style: textTheme.bodyMedium),
                if (windSpeed != null) Text('Wind: $windSpeed m/s', style: textTheme.bodyMedium),
                if (description != null) Text(description.capitalize(), style: textTheme.bodyMedium),
              ],
            ),
          ),
          if (temp != null) Text('$temp°', style: textTheme.headlineLarge),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}