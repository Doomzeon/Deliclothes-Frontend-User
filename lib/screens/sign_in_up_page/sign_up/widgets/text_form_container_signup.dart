import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormContainerSignUp extends StatefulWidget {
  final double widthContainer;
  final String hintText;
  final Function callbackFunction;
  final IconData icon;
  final Function validationCallback;
  final String inputType;
  final int lenghtMax;

  const TextFormContainerSignUp(
      {Key key,
      this.widthContainer,
      this.callbackFunction,
      this.icon,
      this.hintText, this.validationCallback, this.inputType, this.lenghtMax})
      : super(key: key);

  @override
  _TextFormContainerState createState() => _TextFormContainerState();
}

class _TextFormContainerState extends State<TextFormContainerSignUp> {
  bool validationInput = false;
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
              blurRadius: 15.0, color: Colors.grey[400], offset: Offset(15, 0))
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 0, bottom: 5),
      child: TextFormField(
                      inputFormatters: [widget.inputType=='Num'?FilteringTextInputFormatter.digitsOnly:FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
                      LengthLimitingTextInputFormatter(widget.lenghtMax)
                      ],
        
        onChanged: (value) {
          setState(() {
            widget.callbackFunction(value);
             this.validationInput = widget.validationCallback(value);
          });
        },
        style: TextStyle(
            color: Colors.grey[800],
            fontSize: 13.0,
            fontFamily: 'AvenirLight'),
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.icon!=null? Icon(widget.icon, size: 20, color: Colors.grey[800]):null,
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


class DropDownContainer extends StatefulWidget{
  final double widthContainer;
  final List<String> dropDownItems;
  final Function callbackFunction;

  const DropDownContainer({Key key, this.widthContainer, this.dropDownItems, this.callbackFunction}) : super(key: key);
  @override
  _DropDownContainerState createState() => _DropDownContainerState();
}

class _DropDownContainerState extends State<DropDownContainer> {
  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    if (selectedItem == ''){
      selectedItem = widget.dropDownItems[0];
    }
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
      padding: EdgeInsets.only(left: 35, bottom: 0,right: 10),
      child: DropdownButton(
        iconSize: 17,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black
        ),
        isExpanded: true,
        value: selectedItem,
        underline: SizedBox(),
        items: [
          ...widget.dropDownItems.map((e) => DropdownMenuItem(
            value:e,
            child: Text(e.toString()),
          )),
        ], onChanged: (value)=>{
          setState(()=>{
            selectedItem = value,
            widget.callbackFunction(value)
          })
        }
        ),
    );
  }
}