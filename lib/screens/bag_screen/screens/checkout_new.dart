import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/screens/bag_screen/bag.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/adresses.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/bill_info.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/credit_cards_list.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/header_cont_checkout.dart';
import 'package:deliclothes_flutter/screens/bag_screen/widgets/hour_day_container.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPage extends StatefulWidget {
  final int idUser;
  final List<ClothesBag> clothes;

  const CheckoutPage({Key key, this.idUser, this.clothes}) : super(key: key);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ConfirmOrder _orderData = new ConfirmOrder();

  void setHourDelivery(hourDelivery) {
    this._orderData.hourDelivery = hourDelivery;
  }

  void setDayDelivery(dayDelivery) {
    this._orderData.dayDelivery = dayDelivery;
  }

  void setCreditCard(id) {
    this._orderData.creditCardId = id;
  }

  void setAmount(double amount) {
    this._orderData.amount = amount;
  }

  void setStreetAdress(street, city,zipCode) {
    print(street);
    this._orderData.city = city;
    this._orderData.streetName = street;
    this._orderData.zipCode = zipCode;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UserBloc(UserGetInformationInitialState()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, stateInfoUser) {
          if (stateInfoUser is UserGetInformationLoadedSuccess) {
            return BlocProvider(
              create: (context) =>
                  UserBloc(UserGetCardsInformationInitialState()),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, stateCardsUser) {
                  // TODO: implement listener
                },
                builder: (context, stateCardsUser) {
                  if (stateCardsUser is UserGetCardsInformationInitialState) {
                    BlocProvider.of<UserBloc>(context)
                        .add(GetCardsUser(widget.idUser));
                    return Scaffold();
                  } else if (stateCardsUser
                      is UserGetCardsInformationLoadedSuccess) {
                    return BlocProvider(
                      create: (context) => UserBloc(UserProccedInitialPoint()),
                      child: BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, stateHouDelivery) {
                          if (stateHouDelivery is UserConfirmOrderedLoadedSucess) {
                            Navigator.pop(context);
                            return Scaffold(
                              body: Container(),
                            );
                          }
                          if(stateHouDelivery is UserProccedPaymentLoadInProggres || stateHouDelivery is UserConfirmOrderedLoadInProgress){
                            return Scaffold(
                              body: SpinnerContainer(size),
                            );
                          }
                          if (stateHouDelivery is UserProccedInitialPoint) {
                            BlocProvider.of<UserBloc>(context).add(
                                UserProccedPayment(
                                    widget.idUser, widget.clothes));
                            return Scaffold();
                          } else if (stateHouDelivery
                              is UserProccedPaymentHouresDeliveryLoadedeSuccess) {
                            return Scaffold(
                                body: SingleChildScrollView(
                                                                  child: Column(children: [
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
                                    ShoppingBillInfo(
                                      clothes: widget.clothes,
                                      setAmount: this.setAmount,
                                    )
                                  ]),
                                ),
                                bottomNavigationBar: Container(
                                  width: size.width,
                                  height: 94,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          if(this._orderData.hourDelivery !=null && this._orderData.dayDelivery !=null && this._orderData.city !=null && this._orderData.creditCardId != null){
                                          BlocProvider.of<UserBloc>(context)
                                              .add(UserConfirmOrder(
                                                  widget.idUser,
                                                  widget.clothes,
                                                  this._orderData,
                                                  stateHouDelivery.hourInitialDelivery.directions))
                                                  }else{
                                                    //TODO Visualie modal
                                                    print('Data is missing')
                                                  }
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
                                                      right: 35, left: 45),
                                                  child: Icon(
                                                      Icons
                                                          .shopping_bag_outlined,
                                                      color: Colors.white,
                                                      size: 20)),
                                              Text(AppLocalizations.of(context).checkout_page_confirm_button_text,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily:
                                                          'AvenirLight')),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }
                        },
                      ),
                    );
                  } else {
                    return Scaffold();
                  }
                },
              ),
            );
          } else if (stateInfoUser is UserGetInformationInitialState) {
            BlocProvider.of<UserBloc>(context).add(GetInfoUser(widget.idUser));
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
