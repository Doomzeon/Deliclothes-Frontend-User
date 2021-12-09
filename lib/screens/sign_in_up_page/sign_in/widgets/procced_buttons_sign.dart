
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class ProccedButtonSignContainer extends StatefulWidget {
  final String textButton;
  final Color colorButton;
  final Function callbackFunction;
  
  const ProccedButtonSignContainer({
    Key key, this.textButton, this.colorButton, this.callbackFunction,
  }) : super(key: key);

  @override
  _ProccedButtonSignContainerState createState() => _ProccedButtonSignContainerState();
}

class _ProccedButtonSignContainerState extends State<ProccedButtonSignContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width*0.40,
        margin: EdgeInsets.only(left:10,right:10),
        height: 50,
        child: GestureDetector(
          onTap: () => {
            widget.callbackFunction()
          },
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15.0,
                      color: kPrimaryColor,
                      offset: Offset(0, 0))
                ],
                color: widget.colorButton,
                borderRadius: BorderRadius.circular(40)),
            width: 180,
            height: 45,
            child: Center(
              child:Text(widget.textButton,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AvenirLight')),
            ),
          ),
        ));
  }
}
