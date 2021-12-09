import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class DescriptionClothe extends StatefulWidget {
  final String description;

  const DescriptionClothe({Key key, this.description}) : super(key: key);
  @override
  _DescriptionClotheState createState() => _DescriptionClotheState();
}

class _DescriptionClotheState extends State<DescriptionClothe> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
            width: size.width*0.80,
            margin: EdgeInsets.only(left: 30, top: 25),
            child: AutoSizeText(widget.description,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 14.0,
                    fontFamily: 'AvenirLight'))), /*Text(widget.description,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 14.0,
                    fontFamily: 'AvenirLight')))*/
      ],
    );
  }
}
