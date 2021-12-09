import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/credit_cards_user_container.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/main_info_container_user.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatefulWidget {
  final int userId;

  const AccountInfo({Key key, this.userId}) : super(key: key);
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
            create: (context) => UserBloc(UserGetInformationInitialState()),
            child: BlocConsumer<UserBloc, UserState>(
                listener: (context, stateInfoUser) {
              // TODO: implement listener
            }, builder: (context, stateInfoUser) {
              if (stateInfoUser is UserGetInformationLoadedSuccess) {
                return BlocProvider(
                  create: (context) =>
                      UserBloc(UserGetCardsInformationInitialState()),
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, stateCardsUser) {
                      // TODO: implement listener
                    },
                    builder: (context, stateCardsUser) {
                      if (stateCardsUser
                          is UserGetCardsInformationInitialState) {
                        BlocProvider.of<UserBloc>(context)
                            .add(GetCardsUser(widget.userId));
                        return Container();
                      } else if (stateCardsUser
                          is UserGetCardsInformationLoadedSuccess) {
                        return SingleChildScrollView(
                                                  child: Column(
                            children: [
                              MainInfoContainerUser(
                                userData: stateInfoUser.userData,
                                idUser: widget.userId,
                              ),
                              CreditCardsUserContainer(
                                  cards: stateCardsUser.cards,
                                  idUser: widget.userId),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              } else if (stateInfoUser is UserGetInformationInitialState) {
                BlocProvider.of<UserBloc>(context)
                    .add(GetInfoUser(widget.userId));
                return Container();
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
                              .add(GetInfoUser(widget.userId))
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: size.width,
                            height: 70,
                            child: Stack(children: [
                              Positioned(
                                top: 5,
                                left: size.width * 0.29,
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
                                left: size.width * 0.29,
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
            })));
  }
}
