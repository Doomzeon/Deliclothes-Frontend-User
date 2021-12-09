import 'package:deliclothes_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:custom_switch/custom_switch.dart';

import '../../constant.dart';

class Settings extends StatefulWidget {
  //final User user;

  const Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 // final User user;
  bool status = false;
  _SettingsState();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, left: 20),
                      //color: Colors.green,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                            width: 20, color: kTextColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:20),
                  height: 50,
                  color: Colors.white,
                  width: size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notifiche mail di nuovi vestiti e sconti',style:TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            print(status);
                          });
                        },
                        activeTrackColor: kSecondaryColor,
                        activeColor: kSecondaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:20),
                  height: 50,
                  color: Colors.white,
                  width: size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Push notifiche',style:TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            print(status);
                          });
                        },
                        activeTrackColor: kSecondaryColor,
                        activeColor: kSecondaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:20),
                  height: 50,
                  color: Colors.white,
                  width: size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Marketing personalizzato',style:TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            print(status);
                          });
                        },
                        activeTrackColor: kSecondaryColor,
                        activeColor: kSecondaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:20),
                  height: 50,
                  color: Colors.white,
                  width: size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Racolta dati per la perfomance di app',style:TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            print(status);
                          });
                        },
                        activeTrackColor: kSecondaryColor,
                        activeColor: kSecondaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:20),
                  height: 50,
                  color: Colors.white,
                  width: size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Raccolta dati di brand interessanti',style:TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            print(status);
                          });
                        },
                        activeTrackColor: kSecondaryColor,
                        activeColor: kSecondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
