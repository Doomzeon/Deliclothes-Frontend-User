import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/user_info.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AdressContainers extends StatefulWidget {
  final Function setStreetAdress;
  final UserInfo userInfo;

  const AdressContainers({Key key, this.setStreetAdress, this.userInfo})
      : super(key: key);
  @override
  _AdressContainersState createState() => _AdressContainersState();
}


class _AdressContainersState extends State<AdressContainers> {
  String anotherStreet;
int _groupValue = 0;

  var dropdownValue;
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 220,
      //color: Colors.orange,
      child: Column(
        children: [
          Row(children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: Text(AppLocalizations.of(context).checkout_page_street_text,
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 18.0,
                      fontFamily: 'AvenirLight')),
            )
          ]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25, left: 30),
                  width: 330,
                  height: 160,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20.0,
                            color: Colors.grey[400],
                            offset: Offset(0, 0))
                      ],
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 330,
                        height: 25,
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: -15,
                                right: 2,
                                child: Radio(
                                  value: 1,
                                  onChanged: (value) => {
                                    setState(() => {
                                          _groupValue = value,
                                          if (_groupValue == 1)
                                            {
                                              widget.setStreetAdress(
                                                  widget.userInfo.residence,
                                                  widget.userInfo.city,
                                                  widget.userInfo.zipCode)
                                            }
                                        })
                                  },
                                  groupValue: _groupValue,
                                )), //TODO add to radio buttons methjod to change it
                          ],
                        ),
                      ),
                      TextContainerAdressContainer(
                          color: Colors.white,
                          text: AppLocalizations.of(context).checkout_page_street_home_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                      TextContainerAdressContainer(
                          color: Colors.white,
                          text: widget.userInfo.name +
                              ' ' +
                              widget.userInfo.surname +
                              '(+39) ' +
                              widget.userInfo.phoneNumber.toString(),
                          fontWeight: null,
                          fontSize: 14.0),
                      TextContainerAdressContainer(
                          color: Colors.white,
                          text: widget.userInfo.residence +
                              ' Milano', //'via Amerigo vespucci 18 Cormano (MI)',
                          fontWeight: null,
                          fontSize: 13.0),
                      TextContainerAdressContainer(
                          color: Colors.white,
                          text: 'Italia',
                          fontWeight: null,
                          fontSize: 13.0),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 30),
                  width: 330,
                  height: 160,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.grey[400],
                        offset: Offset(0, 0))
                  ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 330,
                        height: 25,
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: -15,
                                right: 2,
                                child: Radio(
                                  value: 2,
                                  onChanged: (value) => {
                                    setState(() => {
                                          _groupValue = value,
                                        })
                                  },
                                  groupValue: _groupValue,
                                )), //TODO add to radio buttons methjod to change it
                          ],
                        ),
                      ),
                      TextContainerAdressContainer(
                          color: kTextColor,
                          text: AppLocalizations.of(context).checkout_page_street_another_street_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                      Container(
                        width: 240,
                        margin: EdgeInsets.only(left: 30, top: 10),
                        height: 20,
                        child: TextFormField(
                            onChanged: (value) {
                              this.anotherStreet = value;
                              setState(() {
                                widget.setStreetAdress(
                                    street: this.anotherStreet,
                                    cityId: widget.userInfo.idCity);
                              });
                            },
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight'),
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).checkout_page_street_another_street_name_text,
                                hintStyle: TextStyle(
                                    color: kTextColor,
                                    fontSize: 13.0,
                                    fontFamily: 'AvenirLight'),
                                border: InputBorder.none)),
                      ),
                      Container(
                        width: 240,
                        margin: EdgeInsets.only(left: 30, top: 0),
                        height: 40,
                        child: DropdownButton(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: kTextColor,
                          ),
                          iconSize: 20,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: kTextColor),
                          items: [
                            DropdownMenuItem(
                              value: 'Milano',
                                child: Container(
                              child: Text(
                                'Milano',
                                style: TextStyle(color:kTextColor),
                              ),
                            )),
                            DropdownMenuItem(
                              value: 'Cormano',
                                child: Container(
                              child: Text(
                                'Cormano',
                                style: TextStyle(color:kTextColor),
                              ),
                            )),
                          ],
                          onChanged: (newValue) {
                              print(newValue);
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                        ),
                      ),
                      TextContainerAdressContainer(
                          color: kTextColor,
                          text: 'Italia',
                          fontWeight: null,
                          fontSize: 13.0),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextContainerAdressContainer extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  const TextContainerAdressContainer({
    Key key,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 30),
        child: Text(this.text,
            style: TextStyle(
                color: this.color,
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                fontFamily: 'AvenirLight')));
  }
}
