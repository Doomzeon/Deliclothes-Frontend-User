import 'dart:convert';

import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/models/delivery_hour_date.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CompletePayment extends StatefulWidget {
  final List<ClothesData> clothes;

  CompletePayment({Key key, this.clothes}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CompletePaymentState(this.clothes);
  }
}

class CompletePaymentState extends State<CompletePayment> {
  final List<ClothesData> clothes;
  double _totalAmountToPay = 0.0;
  String _streetName = '', _doorCode = '';
  User _user;
  TimeOfDay _time; //= TimeOfDay(hour: 14, minute: 30);
  DateTime _date;
  ConfirmOrder orderData = new ConfirmOrder();

  var dropdownValue;

  CompletePaymentState(this.clothes);
  double getTotalAmount() {
    //this.clothes.map((e) => ));
    orderData.amount = this._totalAmountToPay;
    return this._totalAmountToPay;
  }

  @override
  Widget build(BuildContext context) {
    buildCupertinoDatePicker(BuildContext context, DeliveryHourDate data) {
      print(data);
      /*print(DateTime(
          int.parse('20' + data.date.split('/')[2]),
          int.parse(data.date.split('/')[0]),
          int.parse(data.date.split('/')[1]),
          0,
          0));*/
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              color: Colors.white,
              child: CupertinoDatePicker(
                /*minimumDate: DateTime(
                    int.parse('20' + data.date.split('/')[2]),
                    int.parse(data.date.split('/')[0]),
                    int.parse(data.date.split('/')[1])),*/
                maximumDate: DateTime(DateTime.now().year, 12, 1, 1, 0),
                minimumYear: DateTime.now().year,
                maximumYear: DateTime.now().year,
                initialDateTime: DateTime(_date.year, _date.month, _date.day),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                  });
                },
              ),
            );
          });
    }

    

    _totalAmountToPay = 0.0;
    for (var i = 0; i < this.clothes.length; i++) {
      this._totalAmountToPay +=
          this.clothes[i].getPrice() * this.clothes[i].getQuantity();
    }
    Size size = MediaQuery.of(context).size;
    var stateUser = context.select((UserBloc cb) => cb.state);
    //print('State use =>' + stateUser.toString());
    if (stateUser is UserLoginSuccess) {
      //this._user = stateUser.userData;
    }

    return Scaffold(
        body: BlocProvider(
            create: (context) => UserBloc(UserProccedInitialPoint()),
            child:
                BlocConsumer<UserBloc, UserState>(listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              print(state);
              if (state is UserProccedPaymentLoadInProggres) {
                return Container(
                  width: size.width,
                  height: 500,
                  child: Stack(children: [
                    Positioned(
                      top: size.height * 0.35,
                      left: size.width * 0.45,
                      child: SpinKitWanderingCubes(
                          color: kBackgroundHeaderColor, size: 50.0),
                    ),
                  ]),
                );
              } else if (state is UserConfirmOrderedInitialState ||
                  state is UserConfirmOrderedLoadInProgress) {
                return GestureDetector(
                    onTap: () => {
                          print('contacint'),
                          
                        },
                    child: Container(
                      margin: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          border: Border.all(color: kSecondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(40)),
                      width: 180,
                      height: 45,
                    ));
              } else if (state is UserConfirmOrderedLoadedSucess) {
                return Text('OK');
              } else if (state
                  is UserProccedPaymentHouresDeliveryLoadedeSuccess) {
                print(_date);
               /* if (_date == null) {
                  orderData.hourDelivery =
                      state.hourInitialDelivery.hour_start.toString() +
                          ':' +
                          state.hourInitialDelivery.minutes_start.toString();
                  orderData.dayDelivery = state.hourInitialDelivery.date;
                  _date = DateTime(
                      int.parse(
                          '20' + state.hourInitialDelivery.date.split('/')[2]),
                      int.parse(state.hourInitialDelivery.date.split('/')[1]),
                      int.parse(state.hourInitialDelivery.date.split('/')[0]),
                      state.hourInitialDelivery.hour_start,
                      state.hourInitialDelivery.minutes_start);
                }
                if (_time == null) {
                  _time = TimeOfDay(
                      hour: state.hourInitialDelivery.hour_start,
                      minute: state.hourInitialDelivery.minutes_start);
                }*/
                return Column(children: [
                  HeaderCompletePayments(size: size),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(right: kDefaultPadding + 5),
                    decoration: BoxDecoration(),
                    child: GestureDetector(
                        child: Container(
                          width: 250,
                          height: 70,
                          margin: EdgeInsets.only(left: size.width * 0.10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20.0,
                                    color: Colors.grey[400],
                                    offset: Offset(0, 0))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Day of delivery: ' +
                                  _date.day.toString() +
                                  '/' +
                                  _date.month.toString() +
                                  '/' +
                                  _date.year.toString(),
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ),
                        onTap: () {
                          buildCupertinoDatePicker(
                              context, state.hourInitialDelivery);
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(right: kDefaultPadding + 5),
                    decoration: BoxDecoration(),
                    child: GestureDetector(
                        child: Container(
                          width: 250,
                          height: 70,
                          margin: EdgeInsets.only(left: size.width * 0.10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20.0,
                                    color: Colors.grey[400],
                                    offset: Offset(0, 0))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Ora di consegna e ' +
                                  _time.hour.toString() +
                                  ':' +
                                  _time.minute.toString(),
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ),
                        onTap: () {
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: size.width,
                      height: 150,
                      child: Stack(children: [
                        Positioned(
                          top: 35,
                          left: size.width * 0.30,
                          child: GestureDetector(
                            onTap: () => {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  border: Border.all(
                                      color: kSecondaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(40)),
                              width: 180,
                              height: 45,
                              child: Center(
                                child: Text('Completa pagamento!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        fontFamily: 'AvenirLight')),
                              ),
                            ),
                          ),
                        ),
                      ]))
                ]);
              } else if (state is UserProccedInitialPoint) {
                return Column(children: [
                  HeaderCompletePayments(size: size),
                  Container(
                    width: size.width,
                    height: size.height - 150,
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            width: 340,
                            height: 120,
                            margin: EdgeInsets.only(left: size.width * 0.10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20.0,
                                      color: Colors.grey[400],
                                      offset: Offset(0, 0))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(children: [
                              Positioned(
                                top: 15,
                                left: 20,
                                child: Text('Indirizzo di consegna:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'AvenirLight')),
                              ),
                              Positioned(
                                child: Container(
                                  width: 300,
                                  height: 30,
                                  margin: EdgeInsets.only(top: 30, left: 25),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      this._streetName = value;
                                      orderData.streetName = value;
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 13.0,
                                        fontFamily: 'AvenirLight'),
                                    decoration: InputDecoration(
                                        hintText:
                                            "Inserisci l'indirizzo di consegna",
                                        hintStyle: TextStyle(
                                            color: kTextColor,
                                            fontSize: 13.0,
                                            fontFamily: 'AvenirLight'),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(top: 65, left: 25),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      this._doorCode = value;
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 13.0,
                                        fontFamily: 'AvenirLight'),
                                    decoration: InputDecoration(
                                        hintText: "Cittofono:",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 11.0,
                                            fontFamily: 'AvenirLight'),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ), //=>Metodo di pagamento fine
                      /*Row(
                        children: [
                          Container(
                            width: 250,
                            height: 50,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 80, top: 20),
                            child: DropdownButton<String>(
                                hint: Text('Seleziona carta di credito'),
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 14,
                                elevation: 2,
                                style: const TextStyle(color: kTextColor),
                                underline: Container(
                                  height: 0,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    child: Text(this._user.card.card_number),
                                  ),
                                ]),
                          )
                        ],
                      ),*/
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 40, top: 15),
                              width: 340,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/card.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '**** **** **** 1121',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          wordSpacing: 15,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                              color: Colors.black,
                                              offset: Offset(2, 2),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '05 / 20',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'CVC: 878',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),

                      SizedBox(height: 20), //=>Indirizzo di consegna
                      Row(
                        children: [
                          Container(
                            width: 340,
                            height: 150,
                            margin: EdgeInsets.only(left: size.width * 0.10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20.0,
                                      color: Colors.grey[400],
                                      offset: Offset(0, 0))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(children: [
                              Positioned(
                                top: 12,
                                left: 16,
                                child: Text('Riepilogo:',
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'AvenirLight')),
                              ),
                              Positioned(
                                left: 10,
                                top: 50,
                                child: Container(
                                  //color: Colors.orange,
                                  width: 320,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                                'Costo di consegna: 3 £',
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'AvenirLight'))),
                                      ]),
                                      Row(children: [
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                                'Costo di vestiti: ' +
                                                    this
                                                        .getTotalAmount()
                                                        .toString() +
                                                    '£',
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'AvenirLight'))),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 25,
                                child: Text(
                                    'Totale: ' +
                                        (this.getTotalAmount() + 3).toString() +
                                        '£',
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 12.5,
                                        fontFamily: 'AvenirLight')),
                              ),
                            ]),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: size.width,
                              height: 150,
                              child: Stack(children: [
                                Positioned(
                                  top: 35,
                                  left: size.width * 0.27,
                                  child: GestureDetector(
                                    onTap: () => {
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kSecondaryColor,
                                          border: Border.all(
                                              color: kSecondaryColor, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      width: 180,
                                      height: 45,
                                      child: Center(
                                        child: Text('Avanti',
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
                    ]),
                  )
                ]);
              }
            })));
  }
}

class HeaderCompletePayments extends StatelessWidget {
  const HeaderCompletePayments({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: size.width,
          child: Container(
              child: Stack(children: [
            Positioned(
                top: 55,
                left: size.width * 0.30,
                child: Text('Completa il pagamento',
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'AvenirLight'))),
            Positioned(
              top: 40,
              left: 2,
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                    width: 20, color: Colors.grey[500]),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ])),
        )
      ],
    );
  }
}

/*SizedBox(height:20), //=>Indirizzo di consegna
          Row(
            children: [
              Container(
                width: 340,
                height: 80,
                margin: EdgeInsets.only(left: size.width * 0.10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.grey[400],
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(children: [
                  Positioned(
                    top:10,
                    left:12,
                    child: Text('Orarrio di consegna:',style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.0,
                                      fontFamily: 'AvenirLight')),
                  ),

                  Positioned(
                    child: Center(
                      child: DropdownButton(
                        hint: Text('Seleziona Orario di consegna',style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13.0,
                                      fontFamily: 'AvenirLight'),),
                        items: [
                          DropdownMenuItem(value: '1', child: Text('1')),
                          DropdownMenuItem(value: '2', child: Text('2')),
                          DropdownMenuItem(value: '3', child: Text('3')),
                        ],
                        onChanged: (String value) {},
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ), */
