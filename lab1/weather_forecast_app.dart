import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String city;

  WeatherService(this.apiKey, this.city);

  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      var response = await http.get(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class WeatherApp {
  final WeatherService weatherService;
  final Duration updateInterval;
  late StreamController<Map<String, dynamic>> _weatherStreamController;
  late Timer _updateTimer;

  WeatherApp(this.weatherService, this.updateInterval) {
    _weatherStreamController = StreamController<Map<String, dynamic>>();
    _updateTimer = Timer.periodic(updateInterval, (Timer t) => _updateWeather());
  }

  Stream<Map<String, dynamic>> get weatherStream =>
      _weatherStreamController.stream;

  void _updateWeather() async {
    try {
      var weatherData = await weatherService.fetchWeather();
      _weatherStreamController.add(weatherData);
    } catch (e) {
      print('Error updating weather: $e');
    }
  }

  void dispose() {
    _weatherStreamController.close();
    _updateTimer.cancel();
  }
}

void main() {
  final apiKey = '6c17a0caf2258c246ccdf262d201a3a1';
  final city = 'London';
  final weatherService = WeatherService(apiKey, city);
  final updateInterval = Duration(minutes: 10);
  final weatherApp = WeatherApp(weatherService, updateInterval);

  weatherApp.weatherStream.listen((weatherData) {
    print('Weather Update: $weatherData');
  });

  Future.delayed(Duration(hours: 1), () {
    weatherApp.dispose();
    exit(0);
  });
}
