import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import this for kDebugMode

class OpenWeatherMapAPI {
  OpenWeatherMapAPI(this.apiKey);
  final String apiKey;

  final Dio _dio = Dio();

  Future<dynamic> getWeather(String city) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
        },
      );
      showLog('Weather Response: ${prettyJson(response.data)}');
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> getForecast(String city) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
        },
      );
      showLog('Forecast Response: ${prettyJson(response.data)}');
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  void _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      throw Exception('Connection timeout. Please check your internet connection.');
    } else if (error.type == DioExceptionType.sendTimeout) {
      throw Exception('Send timeout. Please try again later.');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw Exception('Receive timeout. Please check your internet connection.');
    } else if (error.type == DioExceptionType.badResponse) {
      if (error.response?.statusCode == 404) {
        throw Exception('City not found. Please check the city name and try again.');
      } else if (error.response?.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API key.');
      } else {
        throw Exception('Failed to load data. Status code: ${error.response?.statusCode}');
      }
    } else if (error.type == DioExceptionType.cancel) {
      throw Exception('Request was cancelled. Please try again.');
    } else {
      throw Exception('Something went wrong. Please try again later.');
    }
  }
  
  void showLog(String value) {
    if (kDebugMode) {
      log(value);
    }
  }

  static String prettyJson(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }
}
