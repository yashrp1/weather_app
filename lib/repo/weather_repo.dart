import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/model/forecase_model.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  WeatherRepository({required this.api});

  final OpenWeatherMapAPI api;

  Future<WeatherData> getWeather(String city) async {
    final data = await api.getWeather(city);
    return WeatherData.fromJson(data);
  }

  Future<Forecast> getForecast(String city) async {
    final data = await api.getForecast(city);
    return Forecast.fromJson(data);
  }
}
