import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';

class ContainerTextFormField extends StatefulWidget {
  final Function calbbackOnTap;
  final String hintText;
  final IconData iconTextForm;
  final bool passwordTextForm;
  final Function validatorCallback;

  const ContainerTextFormField({
    Key key,
    @required this.size,
    this.calbbackOnTap,
    this.hintText,
    this.iconTextForm,
    this.passwordTextForm, this.validatorCallback,
  }) : super(key: key);

  final Size size;

  @override
  _ContainerTextFormFieldState createState() => _ContainerTextFormFieldState();
}

class _ContainerTextFormFieldState extends State<ContainerTextFormField> {
  bool _showPass = false;
  var _formKey = GlobalKey<FormState>();
  String erroreMessage;

  @override
  Widget build(BuildContext context) {
    if(widget.hintText == true){
      this.erroreMessage = widget.validatorCallback('');
    }
    return Row(
      children: [
        Container(
          height: 80,
          width: widget.size.width,
          child: Stack(children: [
            Positioned(
              top: 15,
              left: widget.size.width * 0.13,
              child: Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 30.0,
                                color: this.erroreMessage==null?kTextColor:kRedColor,
                                offset: Offset(0, 0))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: Form(
                          key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                          },
                          controller: null,
                          onChanged: (value) {
                            print(_formKey.currentState.validate());
                            setState(() {
                              widget.calbbackOnTap(value);
                              this.erroreMessage = widget.validatorCallback(value);
                            });
                          },
                          obscureText: widget.passwordTextForm == true
                              ? this._showPass == false
                                  ? true
                                  : false
                              : false,
                              
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight'),
                          decoration: InputDecoration(
                              prefixIcon: Icon(widget.iconTextForm,
                                  size: 22, color: Colors.grey[800]),
                              hintText: widget.hintText,
                              hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 11.0,
                                  fontFamily: 'AvenirLight'),
                              border: InputBorder.none,
                              suffixIcon: widget.passwordTextForm == true
                                  ? GestureDetector(
                                      onLongPressStart: (details) {
                                        this._showPass = true;
                                        setState(() {});
                                      },
                                      onLongPressEnd: (details) {
                                        this._showPass = false;
                                        setState(() {});
                                      },
                                      child: Icon(Icons.visibility_outlined,
                                          size: 20, color: Colors.grey[800]),
                                    )
                                  : null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                    Positioned(
              top: 10,
              left: widget.size.width * 0.15,
                      child: Container(child:Text(this.erroreMessage==null?'':this.erroreMessage,style: TextStyle(color: Colors.white),)))
          ]),
        )
      ],
    );
  }
}
