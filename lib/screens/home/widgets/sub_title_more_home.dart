
import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class SubtitleOfMoreInfo extends StatelessWidget {
  final String title;
  const SubtitleOfMoreInfo({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 30),
            child: Text(title,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 15.0,
                    fontFamily: 'AvenirLight')))
      ],
    );
  }
}

