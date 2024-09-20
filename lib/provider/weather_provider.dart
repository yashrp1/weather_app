import 'package:flutter/foundation.dart';
import 'package:weather_app/model/forecase_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repo/weather_repo.dart';

class WeatherNotifier extends ChangeNotifier {
  WeatherNotifier({required this.weatherRepository});

  final WeatherRepository weatherRepository;

  WeatherData? _currentWeather;
  Forecast? _hourlyForecast;
  bool _isLoading = false;
  String _city = ''; // Default city
  String? _errorMessage;

  WeatherData? get currentWeather => _currentWeather;
  Forecast? get hourlyForecast => _hourlyForecast;
  bool get isLoading => _isLoading;
  String get city => _city; // Getter for city
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentWeather = await weatherRepository.getWeather(city);
      _hourlyForecast = await weatherRepository.getForecast(city);
      _errorMessage = null;
      _city = city; // Update city
    } catch (e) {
      _errorMessage = e.toString();
      _currentWeather = null;
      _hourlyForecast = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  void updateCity(String newCity) {
    fetchWeather(newCity);
  }
}
