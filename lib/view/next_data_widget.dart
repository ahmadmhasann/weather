import 'package:flutter/material.dart';
import 'package:weather_app/controller/home_page_controller.dart';


class NextDataWidget extends StatelessWidget {
  const NextDataWidget({
    Key key,
    @required this.time,
    @required this.temp,
    @required this.icon,
  }) : super(key: key);

  final String time;
  final String temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color(0xFF324158),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Sans',
              color: Colors.white,
            ),

          ),
          Image.asset(icon, width: 80,),
          Text(
            '$temp',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Sans',
              color: Colors.white,
            ),

          ),


        ],


      ),

    );
  }
}
