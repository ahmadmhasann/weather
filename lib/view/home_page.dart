import 'package:flutter/material.dart';
import 'package:weather_app/View/clouds_widget.dart';
import 'package:weather_app/controller/home_page_controller.dart';
import 'next_data_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({this.weatherData, this.cityData});

  final weatherData;
  final cityData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = new HomePageController();

  List<Widget> nextDataWidgets;
  String maxTemp;

  @override
  void initState() {
    homePageController.updateUI(widget.weatherData, widget.cityData);
    homePageController.updateHoursList(widget.weatherData);
    super.initState();
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
      body: Stack(
        children: <Widget>[
          CloudsWidget(),
          Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          homePageController.iconNumber,
                          width: 80,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          homePageController.currentDay,
                          style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 45,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          homePageController.currentDate,
                          style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      homePageController.maxTemp,
                      style: TextStyle(
                        fontSize: 90,
                        fontFamily: 'Sans',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' °C',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Minimum: ${homePageController.minTemp} °C',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans',
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Feels like ${homePageController.feelsLike}  •  ${homePageController.sunSetRise}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Sans',
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  homePageController.cityName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Sans',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                homePageController.updateHoursList(widget.weatherData);
                              });
                            },
                            child: Text(
                              'Next 48 Hours',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Sans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            homePageController.next == 48 ? '•' : ' ',
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                homePageController.updateDaysList(widget.weatherData);
                              });
                            },
                            child: Text(
                              'Next 7 Days',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Sans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            homePageController.next == 8 ? '•' : ' ',
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ]),
                Container(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homePageController.next,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print(index);
                          },
                            child: NextDataWidget(
                                time: homePageController.nextHoursTime[index],
                                temp: homePageController.nextHoursTemp[index],
                                icon: homePageController.nextHoursIcon[index],
                                ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
