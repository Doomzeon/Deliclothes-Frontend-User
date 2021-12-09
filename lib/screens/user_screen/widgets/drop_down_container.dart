

import 'package:flutter/material.dart';

class DropDownContainer extends StatefulWidget{
  final double widthContainer;

  const DropDownContainer({Key key, this.widthContainer}) : super(key: key);
  @override
  _DropDownContainerState createState() => _DropDownContainerState();
}

class _DropDownContainerState extends State<DropDownContainer> {
  var selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: widget.widthContainer,
      height: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 20.0, color: Colors.grey[400], offset: Offset(0, 0))
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 35, bottom: 5,right: 10),
      child: DropdownButton(
        iconSize: 34,
        isExpanded: true,
        value: selectedItem,
        underline: SizedBox(),
        items: [
          DropdownMenuItem(child: Text('+39'))
        ], onChanged: (value)=>{
        }
        ),
    );
  }
}