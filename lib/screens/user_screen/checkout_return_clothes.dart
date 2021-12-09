import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/adresses.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/credit_cards_list.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/header_cont_checkout.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/hour_day_container.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/bill_return_clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutReturnClothes extends StatefulWidget {
  final int userId;
  final List<OrderInfoClothes> clothes;

  const CheckoutReturnClothes({Key key, this.userId, this.clothes})
      : super(key: key);

  @override
  _CheckoutReturnClothesState createState() => _CheckoutReturnClothesState();
}

class _CheckoutReturnClothesState extends State<CheckoutReturnClothes> {
  ConfirmOrder _orderData = new ConfirmOrder();

  void setStreetAdress(street, city, zipCode) {
    print(street);
    this._orderData.city = city;
    this._orderData.streetName = street;
    this._orderData.zipCode = zipCode;
  }

  void setHourDelivery(hourDelivery) {
    this._orderData.hourDelivery = hourDelivery;
  }

  void setDayDelivery(dayDelivery) {
    this._orderData.dayDelivery = dayDelivery;
  }

  void setAmount(double amount) {
    this._orderData.amount = amount;
  }

  void setCreditCard(id) {
    this._orderData.creditCardId = id;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) => UserBloc(UserGetInformationInitialState()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, stateInfoUser) {
          if (stateInfoUser is UserGetInformationLoadedSuccess) {
            return BlocProvider(
              create: (context) =>
                  UserBloc(UserGetHourDateInitialOfReturningInitialState()),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                builder: (context, stateHouDelivery) {
                  if (stateHouDelivery
                      is UserGetHourDateInitialOfReturningLoadInProgress) {
                    return SpinnerContainer(size);
                  } else if (stateHouDelivery
                      is UserGetHourDateInitialOfReturningInitialState) {
                    BlocProvider.of<UserBloc>(context).add(
                        UserGetHourDateInitialOfReturningClothes(
                            widget.userId, widget.clothes));
                    return Container();
                  } else if (stateHouDelivery
                      is UserGetHourDateInitialOfReturningLoadedSuccess) {
                    return BlocProvider(
                        create: (context) =>
                            UserBloc(UserGetCardsInformationInitialState()),
                        child: BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                          // TODO: implement listener
                        }, builder: (context, stateCardsUser) {

                          if (stateCardsUser
                              is UserConfirmOrderedLoadedSucess) {
                            Navigator.pop(context);
                            return Scaffold(
                              body: Container(),
                            );
                          }
                          if (stateCardsUser
                              is UserGetCardsInformationInitialState) {
                            BlocProvider.of<UserBloc>(context)
                                .add(GetCardsUser(widget.userId));
                            return Scaffold(body:Container());
                          } else if (stateCardsUser
                              is UserConfirmOrderedLoadInProgress) {
                            return SpinnerContainer(size);
                          } else if (stateCardsUser
                              is UserGetCardsInformationLoadedSuccess) {
                            return Column(children: [
                              HeaderContainer(),
                              AdressContainers(
                                  userInfo: stateInfoUser.userData,
                                  setStreetAdress: this.setStreetAdress),
                              CreditCardsList(
                                setCreditCard: this.setCreditCard,
                                cards: stateCardsUser.cards,
                              ),
                              HourDelivery(
                                data: stateHouDelivery.hourInitialDelivery,
                                setDayDelivery: this.setDayDelivery,
                                setHourDelivery: this.setHourDelivery,
                              ),
                              BillReturnClothes(
                                setAmount: this.setAmount,
                                clothes: widget.clothes,
                              ),
                              Container(
                                width: size.width,
                                height: 94,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => {
                                        BlocProvider.of<UserBloc>(context).add(
                                            UserConfirmOrderReturnClothes(
                                                widget.userId,
                                                widget.clothes,
                                                this._orderData))
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 350,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Colors.grey[400],
                                                  offset: Offset(0, 0))
                                            ],
                                            color:
                                                kSecondaryColor, //Color(0xfff9de2e),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    right: 35, left: 70),
                                                child: Icon(
                                                    Icons.shopping_bag_outlined,
                                                    color: Colors.white,
                                                    size: 20)),
                                            Text('Conferma il reso',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    fontFamily: 'AvenirLight')),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]);
                          }
                        }));
                  } else {
                    return Column();
                  }
                },
              ),
            );
          } else if (stateInfoUser is UserGetInformationInitialState) {
            BlocProvider.of<UserBloc>(context).add(GetInfoUser(widget.userId));
            return Container();
          } else {
            return Container();
          }
        },
      ),
    ));
  }
}
