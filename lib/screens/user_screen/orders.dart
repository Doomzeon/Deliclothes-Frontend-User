import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Orders extends StatefulWidget {
  final int userId;

  const Orders({Key key, this.userId}) : super(key: key);
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) => UserBloc(UserSelectOrdersInitialState()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is UserSelectOrdersInitialState) {
            BlocProvider.of<UserBloc>(context)
                .add(UserSelectOrders(widget.userId));
            return Container();
          } else if (state is UserSelectOrdersLoadInProgress) {
            return SpinnerContainer(size);
          } else if (state is UserSelectOrdersLoadedSuccess) {
            return Column(children: [
              HeaderContainer(size: size),
              Expanded(
                              child: SingleChildScrollView(
                                child: Column(

                 // children: [...state.orders.map((e) => OrderContainer(order: e,))]
                  ),
                ),
              )
            ]);
          } else {
            return Container(
                    child: Column(children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: size.height * 0.30),
                          width: size.width,
                          child: Center(
                              child: Text('Something wrong with the server.'))),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
            BlocProvider.of<UserBloc>(context)
                .add(UserSelectOrders(widget.userId))
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: size.width,
                            height: 70,
                            child: Stack(children: [
                              Positioned(
                                top: 5,
                                left: size.width * 0.25,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(40)),
                                  width: 180,
                                  height: 45,
                                  child: Center(
                                    child: Text('Retry',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                            fontFamily: 'AvenirLight')),
                                  ),
                                ),
                              ),
                            ])),
                      ),
                      
                    ],
                  ),
                  Row(children: [GestureDetector(
                        onTap: () => {
            Navigator.pop(context)
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: size.width,
                            height: 70,
                            child: Stack(children: [
                              Positioned(
                                top: 5,
                                left: size.width * 0.25,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(40)),
                                  width: 180,
                                  height: 45,
                                  child: Center(
                                    child: Text('Back',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                            fontFamily: 'AvenirLight')),
                                  ),
                                ),
                              ),
                            ])),
                      )],)
                ]));
          }
        },
      ),
    ));
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
      Container(
          margin: EdgeInsets.only(top: 50, left: size.width * 0.20),
          child: Text(
            'Tutti ordini',
            style: TextStyle(
                color: kTextColor, fontSize: 18.0, fontFamily: 'AvenirLight'),
          ))
    ]);
  }
}
