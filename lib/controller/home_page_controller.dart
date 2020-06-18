import 'package:intl/intl.dart';

class HomePageController {
  bool _nextHours = true;
  int _next = 48;
  String _temperature = '';
  String _minTemp = '';
  String _maxTemp = '';
  String _currentDay = '';
  String _currentDate = '';
  String _cityName = '';
  String _feelsLike = '';
  String _sunSetRise = '';
  String _iconNumber = '';
  List<String> _nextHoursTemp = [];
  List<String> _nextHoursIcon = [];
  List<String> _nextHoursTime = [];

  void updateUI(dynamic weatherData, dynamic cityData) {
    _minTemp = weatherData['daily'][0]['temp']['min'].round().toString();
    _maxTemp = weatherData['daily'][0]['temp']['max'].round().toString();
    _cityName =
        cityData['address']['city'] + ', ' + cityData['address']['country'];
    _currentDate = getDateTime(weatherData['current']['dt'], 'MMMM, d');
    _currentDay = getDateTime(weatherData['current']['dt'], 'EEEE');
    _iconNumber =
        'images/' + weatherData['current']['weather'][0]['icon'].toString() + '.png';
    if (weatherData['current']['weather'][0]['icon'].toString().endsWith('n')) {
      _sunSetRise = 'Sunrise at' +
          getDateTime(weatherData['daily'][0]['sunrise'], 'h:mma');
      _feelsLike =
          weatherData['daily'][0]['feels_like']['night'].round().toString();
    } else {
      _sunSetRise = 'Sunset at ' +
          getDateTime(weatherData['daily'][0]['sunset'], 'h:mma');
      _feelsLike =
          weatherData['daily'][0]['feels_like']['day'].round().toString();
    }
  }

  String getDateTime(int timestamp, String formatType) {
    var format = DateFormat(formatType);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var time = format.format(date);
    return time;
  }

  void updateDaysList(dynamic data) {
    _next = 8;
    _nextHoursTemp.clear();
    _nextHoursTime.clear();
    nextHoursIcon.clear();
    for (int counter = 0; counter < 8; counter++) {
      _nextHoursTemp.add(
          data['daily'][counter]['temp']['max'].round().toString() +
              '/' +
              data['daily'][counter]['temp']['min'].round().toString() +
              ' °C');
      _nextHoursTime
          .add(getDateTime(data['daily'][counter]['dt'], 'E\nMMM, d'));
      _nextHoursIcon.add('images/${data['daily'][counter]['weather'][0]['icon']}.png');
    }
  }

  void updateHoursList(dynamic data) {
    _next = 48;
    _nextHoursTemp.clear();
    _nextHoursTime.clear();
    _nextHoursIcon.clear();
    for (int counter = 0; counter < 48; counter++) {
      _nextHoursTemp.add(data['hourly'][counter]['temp'].round().toString() + '°C');
      _nextHoursTime
          .add(getDateTime(data['hourly'][counter]['dt'], 'h a\nMMM, d'));
      _nextHoursIcon.add(
          'images/${data['hourly'][counter]['weather'][0]['icon']}.png');
    }
  }

  String get iconNumber => _iconNumber;

  String get sunSetRise => _sunSetRise;

  String get feelsLike => _feelsLike;

  String get cityName => _cityName;

  String get currentDate => _currentDate;

  String get temperature => _temperature;

  List<String> get nextHoursTime => _nextHoursTime;

  List<String> get nextHoursIcon => _nextHoursIcon;

  List<String> get nextHoursTemp => _nextHoursTemp;

  bool get nextHours => _nextHours;

  String get maxTemp => _maxTemp;

  String get minTemp => _minTemp;

  int get next => _next;

  String get currentDay => _currentDay;
}
