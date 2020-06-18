import 'package:flutter/material.dart';

class CloudsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset('images/cloudl.png', width: 120,)
          ],
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Image.asset('images/cloudr.png', width: 90,)
          ],
        ),
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 80,),
            Image.asset('images/cloud.png', width: 120,)
          ],
        ),
      ],
    );
  }
}
