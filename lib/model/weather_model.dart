// class WeatherData {
//   WeatherData({
//     required this.temp,
//     required this.minTemp,
//     required this.maxTemp,
//     required this.description,
//     required this.date,
//     required this.icon,
//   });

//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     return WeatherData(
//       temp: json['main']['temp'].toDouble(),
//       minTemp: json['main']['temp_min'].toDouble(),
//       maxTemp: json['main']['temp_max'].toDouble(),
//       description: json['weather'][0]['description'],
//       date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
//       icon: json['weather'][0]['icon'],
//     );
//   }

//   final double temp;
//   final double minTemp;
//   final double maxTemp;
//   final String description;
//   final DateTime date;
//   final String icon;

//   String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
// }
class WeatherData {
  WeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: (json['weather'] as List?)?.map((item) => Weather.fromJson(item)).toList(),
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coord {
  Coord({this.lon, this.lat});

  final double? lon;
  final double? lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon']?.toDouble(),
      lat: json['lat']?.toDouble(),
    );
  }
}

class Weather {
  Weather({this.id, this.main, this.description, this.icon});

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp']?.toDouble(),
      feelsLike: json['feels_like']?.toDouble(),
      tempMin: json['temp_min']?.toDouble(),
      tempMax: json['temp_max']?.toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Wind {
  Wind({this.speed, this.deg});

  final double? speed;
  final int? deg;

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed']?.toDouble(),
      deg: json['deg'],
    );
  }
}

class Clouds {
  Clouds({this.all});

  final int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Sys {
  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}