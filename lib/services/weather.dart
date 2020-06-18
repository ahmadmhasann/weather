import 'location.dart';
import 'networking.dart';
const apiKey = 'aac047cb98d80d81db7796d63bd37d8d';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/onecall';
const locationiQ = 'https://us1.locationiq.com/v1/reverse.php?key=4d9197dc1d414c';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    if (location.latitude != null && location.longitude != null) {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
      var weatherData = await networkHelper.getData();
      return weatherData;
    }
    else {
      return 'ERROR';
    }
  }
  Future<dynamic> getCityName() async {

    Location location = Location();
    await location.getCurrentLocation();
    if (location.latitude != null && location.longitude!= null) {
      NetworkHelper networkHelper = NetworkHelper(
          '$locationiQ&lat=${location.latitude}&lon=${location.longitude}&format=json');
      var cityData = await networkHelper.getData();
      return cityData;
    }
    else {
      return 'ERROR';
    }
  }



}
