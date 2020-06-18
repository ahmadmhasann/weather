import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/view/home_page.dart';
import 'package:weather_app/services/weather.dart';
import 'package:android_intent/android_intent.dart';
import 'dart:io' show Platform;

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    var cityData = await weatherModel.getCityName();
    if (weatherData.toString() == 'ERROR' || cityData.toString() == 'ERROR') {
      showAlertDialog(context);
    } else if (weatherData.toString() == 'NOINTERNET' ||
        cityData.toString() == 'NOINTERNET') {
      showAlertDialog(context);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  weatherData: weatherData,
                  cityData: cityData,
                )),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF10102A),
        appBar: AppBar(
          backgroundColor: Color(0xFF0F0F2A),
          title: Center(
            child: Text(
              'Weather Forecast',
              style: TextStyle(
                fontFamily: 'Sans',
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/icon.png',
              width: 150,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Please wait while getting your location',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sans',
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 100.0,
            ),
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    Widget locationButton = FlatButton(
      child: Text("Enable Location Services"),
      onPressed: () {
        AndroidIntent intent = AndroidIntent(
          action: 'action_location_source_settings',
        );
        intent.launch().catchError((e) {
          print(e.toString());
        });
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget settingsButton = FlatButton(
      child: Text("Give Location Access"),
      onPressed: () {
        AndroidIntent intent = AndroidIntent(
          action: 'action_application_details_settings',
          data:
              'package:com.amhapps.weather_app', // replace com.example.app with your applicationId
        );
        intent.launch().catchError((e) {
          print(e.toString());
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Couldn't get location"),
      content: Text(
          "The applications needs active internet connection and access to location to get the weather data"),
      actions: [
        Column(
          children: <Widget>[
            Platform.isAndroid ? settingsButton : Row(),
            Platform.isAndroid ? locationButton : Row(),
            cancelButton,
          ],
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
