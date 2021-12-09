import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class TitleClothe extends StatefulWidget {
  final String title;

  const TitleClothe({Key key, this.title}) : super(key: key);
  @override
  _TitleClotheState createState() => _TitleClotheState();
}

class _TitleClotheState extends State<TitleClothe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 25, top: 15),
            child: Text(widget.title,
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    fontFamily: 'AvenirLight')))
      ],
    );
  }
}
