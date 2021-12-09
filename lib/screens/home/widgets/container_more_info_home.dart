
import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class ContainerMoreInfoAboutSection extends StatelessWidget {
  final String title;
  const ContainerMoreInfoAboutSection({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          Container(
            margin: EdgeInsets.only(left: 25,top:25),
            child: Text(title,
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    fontFamily: 'AvenirLight')),
          )
        ]),
      ],
    );
  }
}