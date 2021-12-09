import 'package:flutter/material.dart';

class TextFormContainer extends StatefulWidget {
  final double widthContainer;
  final String initialValue;
  final Function callbackFunction;
  final IconData icon;

  const TextFormContainer(
      {Key key,
      this.widthContainer,
      this.callbackFunction,
      this.icon,
      this.initialValue})
      : super(key: key);

  @override
  _TextFormContainerState createState() => _TextFormContainerState();
}

class _TextFormContainerState extends State<TextFormContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: widget.widthContainer,
      height: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 20.0, color: Colors.grey[400], offset: Offset(25, 0))
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 0, bottom: 5),
      child: TextFormField(
        initialValue: widget.initialValue,
        onChanged: (value) {
          widget.callbackFunction(value);
        },
        //obscureText: this.showPass == false ? true : false,
        style: TextStyle(
            color: Colors.grey[800],
            fontSize: 13.0,
            fontFamily: 'AvenirLight'),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, size: 20, color: Colors.grey[800]),
          hintStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 11.0,
              fontFamily: 'AvenirLight'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
