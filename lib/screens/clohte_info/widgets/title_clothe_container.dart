import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class TitleConainer extends StatelessWidget {
  final String title;

  const TitleConainer({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, top: 30),
          child: Text(this.title,
              style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'AvenirLight')),
        )
      ],
    );
  }
}
