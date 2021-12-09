import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant.dart';
import '../../main.dart';

class SignInContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignInContainerState();
  }
}

class SignInContainerState extends State<SignInContainer> {
  String username = '', password = '';
  bool showPass = false, _validateEmail = false, _validatePass = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      print(state);
      if (state is UserLoginSuccess) {
      } else {
        return Container(
          height: size.height * 0.50,
          width: size.width,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: size.width,
                    child: Stack(children: [
                      Positioned(
                        top: 15,
                        left: size.width * 0.13,
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
                                          color: this._validateEmail == true
                                              ? kRedColor
                                              : kTextColor,
                                          offset: Offset(0, 0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.only(left: 5, bottom: 5),
                                child: TextFormField(
                                  onChanged: (value) {
                                    this.username = value;
                                    print(this._validateEmail);
                                    if (username.contains('@')) {
                                      this._validateEmail = false;
                                    } else {
                                      this._validateEmail = true;
                                    }
                                    setState(() {});
                                  },
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13.0,
                                      fontFamily: 'AvenirLight'),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person,
                                          size: 22, color: Colors.grey[800]),
                                      hintText: "Inserisci la tua mail",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 11.0,
                                          fontFamily: 'AvenirLight'),
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: size.width,
                    child: Stack(children: [
                      Positioned(
                        top: 15,
                        left: size.width * 0.13,
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
                                          color: this._validatePass == true
                                              ? kRedColor
                                              : kTextColor,
                                          offset: Offset(0, 0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.only(left: 0, bottom: 5),
                                child: TextField(
                                  onChanged: (value) {
                                    this.password = value;
                                    if (this.password != '' &&
                                        this.password != null) {
                                      this._validatePass = false;
                                    } else {
                                      this._validatePass = true;
                                    }
                                    setState(() {});
                                  },
                                  obscureText:
                                      this.showPass == false ? true : false,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13.0,
                                      fontFamily: 'AvenirLight'),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,
                                          size: 22, color: Colors.grey[800]),
                                      hintText: "Inserisci la password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 11.0,
                                          fontFamily: 'AvenirLight'),
                                      border: InputBorder.none,
                                      suffixIcon: GestureDetector(
                                        onLongPressStart: (details) {
                                          this.showPass = true;
                                          setState(() {});
                                        },
                                        onLongPressEnd: (details) {
                                          this.showPass = false;
                                          setState(() {});
                                        },
                                        child: Icon(Icons.visibility,
                                            size: 20, color: Colors.grey[800]),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),

              //buttons sign in/ later
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      height: 150,
                      child: Stack(children: [
                        Positioned(
                          top: 35,
                          left: 15,
                          child: GestureDetector(
                            onTap: () => {
                              if (username == '' ||
                                  this.username == null ||
                                  !(username.contains('@')))
                                {
                                  this._validateEmail = true,
                                  setState(() => {}),
                                }
                              else
                                {
                                  this._validateEmail = false,
                                  if (this.password == '' ||
                                      this.password == null)
                                    {
                                      print('im here'),
                                      this._validatePass = true,
                                      setState(() => {}),
                                      /**/
                                    }
                                  else
                                    {
                                      this._validatePass = false,
                                      print(username),
                                      print(password),
                                      BlocProvider.of<UserBloc>(context)
                                          .add(UserLogin(username, password)),
                                      setState(() => {}),
                                    },

                                  /**/
                                }
                              //onPressedNavItem(3)
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15.0,
                                        color: kPrimaryColor,
                                        offset: Offset(0, 0))
                                  ],
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(40)),
                              width: 180,
                              height: 45,
                              child: Center(
                                child: Text('Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        fontFamily: 'AvenirLight')),
                              ),
                            ),
                          ),
                        ),
                      ])),
                  Container(
                      width: 200,
                      height: 150,
                      child: Stack(children: [
                        Positioned(
                          top: 35,
                          right: 15,
                          child: GestureDetector(
                            onTap: () => {onPressedNavItem(3)},
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15.0,
                                        color: kPrimaryColor,
                                        offset: Offset(0, 0))
                                  ],
                                  color: kRedColor,
                                  borderRadius: BorderRadius.circular(40)),
                              width: 180,
                              height: 45,
                              child: Center(
                                child: Text('Sign In dopo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        fontFamily: 'AvenirLight')),
                              ),
                            ),
                          ),
                        ),
                      ]))
                ],
              )
            ],
          ),
        );
      }
    });
  }
}
