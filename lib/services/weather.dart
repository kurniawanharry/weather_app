import 'package:weather_flutter/services/location.dart';
import 'package:weather_flutter/services/networking.dart';

const apiKey = 'acb47cc85e0272695c47e3376eba27d7';
const url = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkingHelper networkingHelper =
        NetworkingHelper('${url}?q=${cityName}&appid=${apiKey}&units=metric');

    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkingHelper networkingHelper = NetworkingHelper(
        '${url}?lat=${location.latitude}&lon=${location.longtitude}&appid=${apiKey}&units=metric');

    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need coats and boots';
    } else {
      return 'Bring a 👕 just in case';
    }
  }
}
