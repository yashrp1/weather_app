// import 'package:weather_app/model/weather_model.dart';

// class Forecast {
//   Forecast({required this.list});

//   factory Forecast.fromJson(Map<String, dynamic> json) {
//     return Forecast(
//       list: (json['list'] as List)
//           .map((item) => WeatherData.fromJson(item))
//           .toList(),
//     );
//   }

//   final List<WeatherData> list;
// }
import 'package:weather_app/model/weather_model.dart';

class Forecast {
  Forecast({this.cod, this.message, this.cnt, this.list});

  final String? cod;
  final int? message;
  final int? cnt;
  final List<ForecastItem>? list;

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: (json['list'] as List?)?.map((item) => ForecastItem.fromJson(item)).toList(),
    );
  }
}

class ForecastItem {
  ForecastItem({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  final int? dt;
  final Main? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  final String? dtTxt;

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dt: json['dt'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      weather: (json['weather'] as List?)?.map((item) => Weather.fromJson(item)).toList(),
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      visibility: json['visibility'],
      pop: json['pop']?.toDouble(),
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      dtTxt: json['dt_txt'],
    );
  }
}